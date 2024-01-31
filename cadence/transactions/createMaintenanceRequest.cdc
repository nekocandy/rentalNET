import RentalNetMaintenanceStore from 0xNC

transaction(
    report_id: String, 
    report_content: String,
    report_user: Address, 
) {
    prepare(userAccount: AuthAccount) {

    }

    execute {
        RentalNetMaintenanceStore.addReport(
            report_id: report_id,
            report_content: report_content,
            report_user: report_user
        )
    }
}