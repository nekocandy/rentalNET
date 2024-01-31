import RentalNetDisputes from 0xNC

transaction(
    dispute_id: String,
    dispute_open: Bool
) {
    prepare(userAccount: AuthAccount) {

    }

    execute {
        RentalNetDisputes.updateDispute(
            dispute_id: dispute_id,
            dispute_open: dispute_open
        )
    }
}