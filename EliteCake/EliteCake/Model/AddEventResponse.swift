//
//  AddEventResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 05/06/23.
//

import Foundation

// MARK: - AAAEventResponse
struct AddEventResponse: Codable {
    let success: Bool
    let message: String
    let parameters: AddEventParameters
}

// MARK: - Parameters
struct AddEventParameters: Codable {
    let birthday, anniversary: [Anniversary]
}

// MARK: - Anniversary
struct Anniversary: Codable {
    let relationID, type, relationName, merchantID: String
    let uid, createdAt, updatedAt, imagePath: String
    let bonusID, isCreated: Int

    enum CodingKeys: String, CodingKey {
        case relationID = "relation_id"
        case type
        case relationName = "relation_name"
        case merchantID = "merchant_id"
        case uid
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case bonusID = "bonus_id"
        case isCreated = "is_created"
        case imagePath = "image_path"
    }
}
