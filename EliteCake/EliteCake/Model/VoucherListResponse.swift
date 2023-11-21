//
//  VoucherListResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 02/05/23.
//

import Foundation

// MARK: - VoucherListResponse
struct VoucherListResponse: Codable {
    let success: Bool
    let message: String
    let parameters: VoucherListParameters?
}

// MARK: - Parameters
struct VoucherListParameters: Codable {
    let voucher: [VoucherList]
}

// MARK: - Voucher
struct VoucherList: Codable {
    let vouchersID, merchantDetailsMerchantID, uid, vouchersName: String
    let vouchersMinOrderValue, vouchersOff, vouchersCode, vouchersCashbackCoins: String?
    let maxAmount: String?
    let maxUsage, intervals: String
    let instant: String?
    let cod, onlinePayment, customerApplicable, publishDate: String?
    let publishTime, validUpto, notification, sheduleTime: String
    let sheduleDate, status, publishInstant, used: String
    let maxAmountForCashback, maxAmountForInstant: String
    let descriptionShow: String?
    let description, customerApplicableClass, instantPercent: String

    enum CodingKeys: String, CodingKey {
        case vouchersID = "vouchers_id"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
        case vouchersName = "vouchers_name"
        case vouchersMinOrderValue = "vouchers_min_order_value"
        case vouchersOff = "vouchers_off"
        case vouchersCode = "vouchers_code"
        case vouchersCashbackCoins = "vouchers_cashback_coins"
        case maxAmount = "max_amount"
        case maxUsage = "max_usage"
        case intervals, instant, cod
        case onlinePayment = "online_payment"
        case customerApplicable = "customer_applicable"
        case publishDate = "publish_date"
        case publishTime = "publish_time"
        case validUpto = "valid_upto"
        case notification
        case sheduleTime = "shedule_time"
        case sheduleDate = "shedule_date"
        case status
        case publishInstant = "publish_instant"
        case used
        case maxAmountForCashback = "max_amount_for_cashback"
        case maxAmountForInstant = "max_amount_for_instant"
        case descriptionShow = "description_show"
        case description
        case customerApplicableClass = "customer_applicable_class"
        case instantPercent = "instant_percent"
    }
}

