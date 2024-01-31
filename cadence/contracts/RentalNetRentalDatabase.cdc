pub contract RentalNetRentalDatabase {
    pub struct HouseInformation {
        pub let id: String
        pub let location: String
        pub let image: String

        init(
            id: String,
            location: String,
            image: String
        ) {
            self.id = id
            self.location = location
            self.image = image
        }
    }

    pub struct RentalInformation {
        pub let owner: Address
        pub let renter: Address
        pub let rental_price: UFix64
        pub let security_deposit: UFix64
        pub let agreement_txn: String
        pub let house_information: HouseInformation
        pub let last_rent_paid: UFix64


        init(
            owner: Address,
            renter: Address,
            rental_price: UFix64,
            security_deposit: UFix64,
            agreement_txn: String,
            last_rent_paid: UFix64,
            house_information: HouseInformation
        ) {
            self.owner = owner
            self.renter = renter
            self.rental_price = rental_price
            self.security_deposit = security_deposit
            self.agreement_txn = agreement_txn
            self.last_rent_paid = last_rent_paid
            self.house_information = house_information
        }
    }

    pub var rent_collection: [RentalInformation]

    pub fun add_rental_information(
        id: String,
        location: String,
        image: String,
        owner: Address,
        renter: Address,
        rental_price: UFix64,
        security_deposit: UFix64,
        agreement_txn: String
    ) {
        let timestamp = getCurrentBlock().timestamp
        let house_information = HouseInformation(
            id: id,
            location: location,
            image: image
        )

        let rental_information = RentalInformation(
            owner: owner,
            renter: renter,
            rental_price: rental_price,
            security_deposit: security_deposit,
            agreement_txn: agreement_txn,
            last_rent_paid: timestamp,
            house_information: house_information
        )

        self.rent_collection.append(rental_information)
    }

    init() {
        self.rent_collection = []
    }

}