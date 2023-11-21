//
//  GetSizeDetailsResponse.swift
//  EliteCake
//
//  Created by TechnoTackle on 30/08/23.
//

import Foundation


// MARK: - GetSizeDratilsResponse
struct GetSizeDratilsResponse: Codable {
    let success: Bool
    let message: String
    let parameters: [GetSizeDratilsParameter]
}

// MARK: - Parameter
struct GetSizeDratilsParameter: Codable {
    let sizeID, sizeName, unitID, merchantDetailsMerchantID: String
    let uid: String
    let unit: GetUnit

    enum CodingKeys: String, CodingKey {
        case sizeID = "size_id"
        case sizeName = "size_name"
        case unitID = "unit_id"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid, unit
    }
}

// MARK: - Unit
struct GetUnit: Codable {
    let unitID, unitName, unitStatus, unitCreated: String
    let unitUpdated, merchantDetailsMerchantID, uid: String

    enum CodingKeys: String, CodingKey {
        case unitID = "unit_id"
        case unitName = "unit_name"
        case unitStatus = "unit_status"
        case unitCreated = "unit_created"
        case unitUpdated = "unit_updated"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
    }
}
