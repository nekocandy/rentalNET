// By signing this transaction you agree to the terms of service of Renter
import RentAgreementEntry from 0xNC

transaction(path: StoragePath) {
    prepare(userAccount: AuthAccount) {
        userAccount.load<Bool>(from: path)
        userAccount.save(true, to: path)
        RentAgreementEntry.RecordAgreement(addr: userAccount.address)
    }
}