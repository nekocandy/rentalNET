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

export interface NoticeData {
  notice_id: string
  notice_content: string
  notice_timestamp: string
  notice_user: string
  notice_open: boolean
}

export interface NoticeData {
  notice_id: string
  notice_content: string
  notice_timestamp: string
  notice_user: string
  notice_open: boolean
}

export interface DisputeData {
  dispute_id: string
  dispute_content: string
  dispute_timestamp: string
  dispute_user: string
  dispute_open: boolean
}
