//
//  FetchAddOnResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 03/07/23.
//

import Foundation


//// MARK: - FetchAddOnResponse
//struct FetchAddOnResponse: Codable {
//    let success: Bool
//    let message: String
//    let parameters: [FetchAddOnParameter]
//}
//
//// MARK: - Parameter
//struct FetchAddOnParameter: Codable {
//    let addonID, addonCategoryID, addonName, addonSize: String
//    let addonPrice, addonStatus, merchantDetailsMerchantID, uid: String
//    let addonImage, sequenceNo: String
//
//    enum CodingKeys: String, CodingKey {
//        case addonID = "addon_id"
//        case addonCategoryID = "addon_category_id"
//        case addonName = "addon_name"
//        case addonSize = "addon_size"
//        case addonPrice = "addon_price"
//        case addonStatus = "addon_status"
//        case merchantDetailsMerchantID = "merchant_details_merchant_id"
//        case uid
//        case addonImage = "addon_image"
//        case sequenceNo = "sequence_no"
//    }
//}


// MARK: - FetchAddOnResponse
struct FetchAddOnResponse: Codable {
    let success: Bool
    let message: String
    let parameters: FetchAddOnParameters?
}

// MARK: - Parameters
struct FetchAddOnParameters: Codable {
    let addon: [FetchAddon]
    let category: FetchCategory
}

// MARK: - Addon
struct FetchAddon: Codable {
    let addonID, addonCategoryID, addonName, addonSize: String?
    let addonPrice, addonStatus, merchantDetailsMerchantID, uid: String
    let addonImage, sequenceNo: String

    enum CodingKeys: String, CodingKey {
        case addonID = "addon_id"
        case addonCategoryID = "addon_category_id"
        case addonName = "addon_name"
        case addonSize = "addon_size"
        case addonPrice = "addon_price"
        case addonStatus = "addon_status"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
        case addonImage = "addon_image"
        case sequenceNo = "sequence_no"
    }
}

// MARK: - Category
struct FetchCategory: Codable {
    let addonCategoryID, addonCategoryName, addonCategorySequenceNo: String
    var multipleSelection: String
    let addonCategoryStatus, merchantDetailsMerchantID, uid: String

    enum CodingKeys: String, CodingKey {
        case addonCategoryID = "addon_category_id"
        case addonCategoryName = "addon_category_name"
        case addonCategorySequenceNo = "addon_category_sequence_no"
        case multipleSelection = "multiple_selection"
        case addonCategoryStatus = "addon_category_status"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
    }
}
