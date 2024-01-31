import RentalNetNoticeBoard from 0xNC

transaction(
    notice_id: String, 
    notice_content: String,
    notice_user: Address, 
) {
    prepare(userAccount: AuthAccount) {

    }

    execute {
        RentalNetNoticeBoard.addNotice(
            notice_id: notice_id, 
            notice_content: notice_content,
            notice_user: notice_user, 
        )
    }
}