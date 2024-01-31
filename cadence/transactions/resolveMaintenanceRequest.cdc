import RentalNetMaintenanceStore from 0xNC

transaction(
    report_id: String,
    report_open: Bool
) {
    prepare(userAccount: AuthAccount) {

    }

    execute {
        RentalNetMaintenanceStore.updateReport(
            report_id: report_id,
            report_open: report_open
        )
    }
}