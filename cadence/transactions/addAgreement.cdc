import RentalNetRentalDatabase from 0xNC

transaction(
    id: String,
    location: String,
    image: String,
    owner: Address,
    renter: Address,
    rental_price: UFix64,
    security_deposit: UFix64,
    agreement_txn: String
) {
    prepare(userAccount: AuthAccount) {

    }

    execute {
        RentalNetRentalDatabase.add_rental_information(
            id: id,
            location: location, 
            image: image, 
            owner: owner, 
            renter: renter, 
            rental_price: rental_price, 
            security_deposit: security_deposit, 
            agreement_txn: agreement_txn
        )
    }
}