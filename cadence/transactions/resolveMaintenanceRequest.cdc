import RentalNetMaintenanceStore from 0xNC

transaction(
    report_id: String,
    report_complete: Bool
) {
    prepare(userAccount: AuthAccount) {

    }

    execute {
        RentalNetMaintenanceStore.updateReport(
            report_id: String,
            report_complete: Bool
        )
    }
}