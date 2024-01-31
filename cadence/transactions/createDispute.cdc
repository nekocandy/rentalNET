import RentalNetDisputes from 0xNC

transaction(
    dispute_id: String, 
    dispute_content: String,
    dispute_user: Address, 
) {
    prepare(userAccount: AuthAccount) {

    }

    execute {
        RentalNetDisputes.addDispute(
            dispute_id: dispute_id, 
            dispute_content: dispute_content,
            dispute_user: dispute_user, 
        )
    }
}