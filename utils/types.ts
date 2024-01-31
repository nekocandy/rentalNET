export interface RentalInformation {
  owner: string
  renter: string
  rental_price: string
  security_deposit: string
  agreement_txn: string
  house_information: HouseInformation
  last_rent_paid: string
}

export interface HouseInformation {
  id: string
  location: string
  image: string
}

export interface ReportData {
  report_id: string
  report_content: string
  report_timestamp: string
  report_user: string
  report_open: boolean
}
