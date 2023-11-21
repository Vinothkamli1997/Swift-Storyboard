//
//  FilterFetchResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 08/03/23.
//

import Foundation

// MARK: - FilterFetchResponse
struct FilterFetchResponse: Codable {
    let success: Bool
    let message: String
    let parameters: FilterFetchParameters?
}

// MARK: - Parameters
struct FilterFetchParameters: Codable {
    let tagCategoryID: [TagCategoryID]
    let tagID: [TagID]

    enum CodingKeys: String, CodingKey {
        case tagCategoryID = "tag_category_id"
        case tagID = "tag_id"
    }
}

// MARK: - TagCategoryID
struct TagCategoryID: Codable {
    let tagCategoryID: String

    enum CodingKeys: String, CodingKey {
        case tagCategoryID = "tag_category_id"
    }
}

// MARK: - TagID
struct TagID: Codable {
    let tagID: String

    enum CodingKeys: String, CodingKey {
        case tagID = "tag_id"
    }
}
