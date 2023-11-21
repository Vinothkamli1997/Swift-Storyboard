//
//  WelcomeResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 31/03/23.
//

import Foundation

// MARK: - WelcomeResponse
struct WelcomeResponse: Codable {
    let success: Bool
    let message: String
    let parameters: WelcomeParameters
}

// MARK: - Parameters
struct WelcomeParameters: Codable {
    let earnedCoin, earnedAmount: MyValue?
    let history: [History]
    let usedCoin, usedAmount: MyValue?
    let balanceCoin: MyValue?
    let balanceAmount: Int

    enum CodingKeys: String, CodingKey {
        case earnedCoin = "earned_coin"
        case earnedAmount = "earned_amount"
        case history
        case usedCoin = "used_coin"
        case usedAmount = "used_amount"
        case balanceCoin = "balance_coin"
        case balanceAmount = "balance_amount"
    }
}

// MARK: - History
struct History: Codable {
    let ledgerID, type, superCoin, cameFrom: String?
    let addedAt, customerID, merchantID, outletID: String?
    let orderID, coinAmount, eventID, message: String?

    enum CodingKeys: String, CodingKey {
        case ledgerID = "ledger_id"
        case type
        case superCoin = "super_coin"
        case cameFrom = "came_from"
        case addedAt = "added_at"
        case customerID = "customer_id"
        case merchantID = "merchant_id"
        case outletID = "outlet_id"
        case orderID = "order_id"
        case coinAmount = "coin_amount"
        case eventID = "event_id"
        case message
    }
}


enum MyValue: Codable {

 case string(String)

 var stringValue: String? {
    switch self {
    case .string(let s):
        return s
    }
 }

init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if let x = try? container.decode(String.self) {
        self = .string(x)
        return
    }
    if let x = try? container.decode(Int.self) {
        self = .string("\(x)")
        return
    }
    throw DecodingError.typeMismatch(MyValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MyValue"))
}

func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    switch self {
    case .string(let x):
        try container.encode(x)
    }
}
}

