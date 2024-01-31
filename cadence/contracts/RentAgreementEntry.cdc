/**
This contract is used to record the agreement between the renter and the rentee.

Anyone signing this contract is considered to be accepting the terms and conditions set by the renter.
*/

pub contract RentAgreementEntry {
    pub event RentAgreementE(renterAddress: Address, signedTimestamp: UFix64)

    pub fun RecordAgreement(addr: Address) {
        emit RentAgreementE(renterAddress: addr, signedTimestamp: getCurrentBlock().timestamp)
    }
}
