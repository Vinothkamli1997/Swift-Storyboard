//
//  WalletEarnCoinsResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 01/06/23.
//

import Foundation


//// MARK: - WalletEarnCoinsResponse
//struct WalletEarnCoinsResponse: Codable {
//    let success: Bool
//    let message: String
//    let parameters: [WalletEarnCoinsParameter]
//}
//
//// MARK: - Parameter
//struct WalletEarnCoinsParameter: Codable {
//    let eventID, eventName, amount, createdAt: String?
//    let merchantID, uid, description: String?
//    let ledgerID, type, superCoin, cameFrom: String?
//    let addedAt, customerID, outletID, orderID: String?
//    let coinAmount: String?
//    let message: String?
//
//    enum CodingKeys: String, CodingKey {
//        case eventID = "event_id"
//        case eventName = "event_name"
//        case amount
//        case createdAt = "created_at"
//        case merchantID = "merchant_id"
//        case uid, description
//        case ledgerID = "ledger_id"
//        case type
//        case superCoin = "super_coin"
//        case cameFrom = "came_from"
//        case addedAt = "added_at"
//        case customerID = "customer_id"
//        case outletID = "outlet_id"
//        case orderID = "order_id"
//        case coinAmount = "coin_amount"
//        case message
//    }
//}

// MARK: - WalletEarnCoinsResponse
struct WalletEarnCoinsResponse: Codable {
    let success: Bool
    let message: String
    let parameters: [WalletEarnCoinsParameter]
}

// MARK: - Parameter
struct WalletEarnCoinsParameter: Codable {
    let eventID, eventName, amount, createdAt: String
    let merchantID, uid, description: String?
    let ledgerID, type, superCoin, cameFrom: String?
    let addedAt, customerID, outletID, orderID: String?
    let coinAmount, downlineCusID: String?
    let message: String?
    let isClaimBtnShow: Int
    let errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case eventID = "event_id"
        case eventName = "event_name"
        case amount
        case createdAt = "created_at"
        case merchantID = "merchant_id"
        case uid, description
        case ledgerID = "ledger_id"
        case type
        case superCoin = "super_coin"
        case cameFrom = "came_from"
        case addedAt = "added_at"
        case customerID = "customer_id"
        case outletID = "outlet_id"
        case orderID = "order_id"
        case coinAmount = "coin_amount"
        case downlineCusID = "downline_cus_id"
        case message
        case isClaimBtnShow = "is_claim_btn_show"
        case errorMessage = "error_message"
    }
}
