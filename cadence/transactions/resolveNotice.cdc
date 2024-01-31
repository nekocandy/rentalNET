import RentalNetNoticeBoard from 0xNC

transaction(
    notice_id: String,
    notice_open: Bool
) {
    prepare(userAccount: AuthAccount) {

    }

    execute {
        RentalNetNoticeBoard.updateNotice(
            notice_id: notice_id,
            notice_open: notice_open
        )
    }
}