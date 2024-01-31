pub contract RentalNetMaintenanceStore {
    pub struct ReportInformation {
        pub let report_id: String
        pub let report_content: String
        pub let report_timestamp: UFix64
        pub let report_user: String
        pub (set) var report_open: Bool

        init(
            report_id: String, 
            report_content: String,
            report_user: String,
        ) {
            self.report_id = report_id
            self.report_content = report_content
            self.report_timestamp = getCurrentBlock().timestamp
            self.report_user = report_user
            self.report_open = true
        }
    }

    pub var report_store: [ReportInformation]

    pub fun addReport(
        report_id: String, 
        report_content: String,
        report_user: String, 
    ) {
        let new_report = ReportInformation(
            report_id: report_id, 
            report_content: report_content,
            report_user: report_user, 
        )
        self.report_store.append(new_report)
    }

    pub fun updateReport(
        report_id: String,
        report_complete: Bool
    ) {
        for report in self.report_store {
            if report.report_id == report_id {
                report.report_open = report_complete
            }
        }
    }

    init() {
        self.report_store = []
    }
}