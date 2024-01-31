// By signing this transaction you agree to the terms of service of Renter
import RentAgreementEntry from 0xNC

transaction() {
    prepare(userAccount: AuthAccount) {
        userAccount.load<Bool>(from: /storage/kiraiRentTerms)
        userAccount.save(true, to: /storage/KiraiRentTerms)
        RentAgreementEntry.RecordAgreement(addr: userAccount.address)
    }
}