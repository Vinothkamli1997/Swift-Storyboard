//
//  FilterResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 02/03/23.
//

import Foundation


// MARK: - FilterResponse
struct FilterResponse: Codable {
    let success: Bool
    let message: String
    let parameters: FilterParameters
}

// MARK: - Parameters
struct FilterParameters: Codable {
    let filters: [Filter]
    let tagCatName, tagSub: JSONNull?

    enum CodingKeys: String, CodingKey {
        case filters
        case tagCatName = "tag_cat_name"
        case tagSub = "tag_sub"
    }
}

// MARK: - Filter
struct Filter: Codable {
    let tagCategoryID, tagCategoryName: String
    let tagCategoryImage: JSONNull?
    let tagCategoryStatus: String
    let tagCategoryCreated, tagCategoryUpdated, merchantDetailsMerchantID, uid: String
    let tagCategorySequenceNo: String
    let tagsActive: [TagsActive]
    let count: Int
    let isChecked,lastlySelected: Int

    enum CodingKeys: String, CodingKey {
        case tagCategoryID = "tag_category_id"
        case tagCategoryName = "tag_category_name"
        case tagCategoryImage = "tag_category_image"
        case tagCategoryStatus = "tag_category_status"
        case tagCategoryCreated = "tag_category_created"
        case tagCategoryUpdated = "tag_category_updated"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
        case tagCategorySequenceNo = "tag_category_sequence_no"
        case tagsActive = "tags_active"
        case count
        case isChecked = "is_checked"
        case lastlySelected = "lastly_selected"
    }
}


// MARK: - TagsActive
struct TagsActive: Codable {
    let tagsID, tagsName: String
    let tagsStatus: String
    let tagCategoryID, merchantDetailsMerchantID, uid, tagsSequenceNo: String
    var isChecked: Int

    enum CodingKeys: String, CodingKey {
        case tagsID = "tags_id"
        case tagsName = "tags_name"
        case tagsStatus = "tags_status"
        case tagCategoryID = "tag_category_id"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
        case tagsSequenceNo = "tags_sequence_no"
        case isChecked = "is_checked"
    }
}
