pub contract RentalNetNoticeBoard {
    pub struct Notice {
        pub let notice_id: String
        pub let notice_content: String
        pub let notice_timestamp: UFix64
        pub let notice_user: Address
        pub (set) var notice_open: Bool

        init(
            notice_id: String, 
            notice_content: String,
            notice_user: Address,
        ) {
            self.notice_id = notice_id
            self.notice_content = notice_content
            self.notice_timestamp = getCurrentBlock().timestamp
            self.notice_user = notice_user
            self.notice_open = true
        }
    }

    pub event noticeUpdated(
        notice_id: String,
        notice_open: Bool
    )
    pub var notice_store: [Notice]

    pub fun addNotice(
        notice_id: String, 
        notice_content: String,
        notice_user: Address, 
    ) {
        let new_notice = Notice(
            notice_id: notice_id, 
            notice_content: notice_content,
            notice_user: notice_user, 
        )
        self.notice_store.append(new_notice)
    }

    pub fun updatenotice(
        notice_id: String,
        notice_open: Bool
    ) {
        for notice in self.notice_store {
            if notice.notice_id == notice_id {
                notice.notice_open = notice_open
                emit noticeUpdated(
                    notice_id: notice_id,
                    notice_open: notice_open
                )
            }
        }
    }

    init() {
        self.notice_store = []
    }
}