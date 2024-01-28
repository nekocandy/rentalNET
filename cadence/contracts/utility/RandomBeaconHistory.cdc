access(all) contract RandomBeaconHistory {

    /// The height at which the first source of randomness was recorded
    access(contract) var lowestHeight: UInt64?
    /// Sequence of random sources recorded by the Heartbeat, stored as an array over a mapping to reduce storage
    access(contract) let randomSourceHistory: [[UInt8]]

    /// The path of the Heartbeat resource in the deployment account
    access(all) let HeartbeatStoragePath: StoragePath

    /* --- Hearbeat --- */
    //
    /// The Heartbeat resource containing each block's source of randomness in sequence
    ///
    access(all) resource Heartbeat {

        /// Callable by owner of the Heartbeat resource, Flow Service Account, records the provided random source
        ///
        /// @param randomSourceHistory The random source to record
        ///
        access(all) fun heartbeat(randomSourceHistory: [UInt8]) {

            let currentBlockHeight = getCurrentBlock().height
            if RandomBeaconHistory.lowestHeight == nil {
                RandomBeaconHistory.lowestHeight = currentBlockHeight
            }

            RandomBeaconHistory.randomSourceHistory.append(randomSourceHistory)
        }
    }

    /* --- RandomSourceHistory --- */
    //
    /// Represents a random source value for a given block height
    ///
    access(all) struct RandomSource {
        access(all) let blockHeight: UInt64
        access(all) let value: [UInt8]
    
        init(blockHeight: UInt64, value: [UInt8]) {
            self.blockHeight = blockHeight
            self.value = value
        }
    }

    /* --- RandomSourceHistoryPage --- */
    //
    /// Contains RandomSource values ordered chronologically according to associated block height
    ///
    access(all) struct RandomSourceHistoryPage {
        access(all) let page: UInt64
        access(all) let perPage: UInt64
        access(all) let totalLength: UInt64
        access(all) let values: [RandomSource]
    
        init(page: UInt64, perPage: UInt64, totalLength: UInt64, values: [RandomSource]) {
            self.page = page
            self.perPage = perPage
            self.totalLength = totalLength
            self.values = values
        }
    }

    /* --- Contract Methods --- */
    //
    /// Getter for the source of randomness at a given block height. Panics if the requested block height either
    /// precedes or exceeds the recorded history. Note that a source of randomness for block n will not be accessible
    /// until block n+1.
    ///
    /// @param atBlockHeight The block height at which to retrieve the source of randomness
    ///
    /// @return The source of randomness at the given block height as RandomSource struct
    ///
    access(all) fun sourceOfRandomness(atBlockHeight blockHeight: UInt64): RandomSource {
        pre {
            self.lowestHeight != nil: "History has not yet been initialized"
            blockHeight >= self.lowestHeight!: "Requested block height precedes recorded history"
            blockHeight < getCurrentBlock().height: "Source of randomness not yet recorded"
        }
        let index = blockHeight - self.lowestHeight!
        assert(
            index >= 0 && index < UInt64(self.randomSourceHistory.length),
            message: "Problem finding random source history index"
        )
        return RandomSource(blockHeight: blockHeight, value: self.randomSourceHistory[index])
    }

    /// Retrieves a page from the history of random sources, ordered chronologically
    ///
    /// @param page: The page number to retrieve, 0-indexed
    /// @param perPage: The number of random sources to include per page
    ///
    /// @return A RandomSourceHistoryPage containing RandomSource values in choronological order according to
    /// associated block height
    ///
    access(all) view fun getRandomSourceHistoryPage(_ page: UInt64, perPage: UInt64): RandomSourceHistoryPage {
        pre {
            self.lowestHeight != nil: "History has not yet been initialized"
        }
        let values: [RandomSource] = []
        let totalLength = UInt64(self.randomSourceHistory.length)

        var startIndex = page * perPage
        if startIndex > totalLength {
            startIndex = totalLength
        }
        var endIndex = startIndex + perPage
        if endIndex > totalLength {
            endIndex = totalLength
        }
        // Return empty page if request exceeds last page
        if startIndex == endIndex {
            return RandomSourceHistoryPage(page: page, perPage: perPage, totalLength: totalLength, values: values)
        }

        // Iterate over history and construct page RandomSource values
        let lowestHeight = self.lowestHeight!
        for i, block in self.randomSourceHistory.slice(from: Int(startIndex), upTo: Int(endIndex)) {
            values.append(
                RandomSource(
                    blockHeight: lowestHeight + startIndex + UInt64(i),
                    value: self.randomSourceHistory[startIndex + UInt64(i)]
                )
            )
        }

        return RandomSourceHistoryPage(
            page: page,
            perPage: perPage,
            totalLength: totalLength,
            values: values
        )
    }

    /// Getter for the block height at which the first source of randomness was recorded
    ///
    /// @return The block height at which the first source of randomness was recorded
    ///
    access(all) view fun getLowestHeight(): UInt64 {
        return self.lowestHeight ?? panic("History has not yet been initialized")
    }

    init() {
        self.lowestHeight = nil
        self.randomSourceHistory = []
        self.HeartbeatStoragePath = /storage/FlowRandomBeaconHistoryHeartbeat

        self.account.save(<-create Heartbeat(), to: self.HeartbeatStoragePath)
    }
}
