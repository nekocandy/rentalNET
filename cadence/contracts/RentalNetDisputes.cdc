pub contract RentalNetDisputes {
    pub struct Dispute {
        pub let dispute_id: String
        pub let dispute_content: String
        pub let dispute_timestamp: UFix64
        pub let dispute_user: Address
        pub (set) var dispute_open: Bool

        init(
            dispute_id: String, 
            dispute_content: String,
            dispute_user: Address,
        ) {
            self.dispute_id = dispute_id
            self.dispute_content = dispute_content
            self.dispute_timestamp = getCurrentBlock().timestamp
            self.dispute_user = dispute_user
            self.dispute_open = true
        }
    }

    pub event noticeUpdated(
        dispute_id: String,
        dispute_open: Bool
    )
    pub var dispute_store: [Dispute]

    pub fun addDispute(
        dispute_id: String, 
        dispute_content: String,
        dispute_user: Address, 
    ) {
        let new_notice = Dispute(
            dispute_id: dispute_id, 
            dispute_content: dispute_content,
            dispute_user: dispute_user, 
        )
        self.dispute_store.append(new_notice)
    }

    pub fun updateDispute(
        dispute_id: String,
        dispute_open: Bool
    ) {
        for notice in self.dispute_store {
            if notice.dispute_id == dispute_id {
                notice.dispute_open = dispute_open
                emit noticeUpdated(
                    dispute_id: dispute_id,
                    dispute_open: dispute_open
                )
            }
        }
    }

    init() {
        self.dispute_store = []
    }
}