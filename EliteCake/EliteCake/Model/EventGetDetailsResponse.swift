//
//  EventGetDetailsResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 09/06/23.
//

import Foundation

// MARK: - EventGetDetailsResponse
struct EventGetDetailsResponse: Codable {
    let success: Bool
    let message: String
    let parameters: EventGetDetailsParameters
}

// MARK: - Parameters
struct EventGetDetailsParameters: Codable {
    let relation: Relation
}

// MARK: - Relation
struct Relation: Codable {
    let bonusID, relationID, customerID, coin: String
    let amount, createdAt, updatedAt, merchantID: String
    var uid, imagePath, name, date: String
    var mobileNo: String

    enum CodingKeys: String, CodingKey {
        case bonusID = "bonus_id"
        case relationID = "relation_id"
        case customerID = "customer_id"
        case coin, amount
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case merchantID = "merchant_id"
        case uid
        case imagePath = "image_path"
        case name, date
        case mobileNo = "mobile_no"
    }
}
