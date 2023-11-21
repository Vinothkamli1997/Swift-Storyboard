//
//  GmailResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 10/02/23.
//

import Foundation

// MARK: - GmailResponse
struct GmailResponse: Codable {
    let success: Bool
    let message: String
    let parameters: GmailParameters
}

// MARK: - Parameters
struct GmailParameters: Codable {
    let customerDetailsID, message: String
    let isNewUser: Int

    enum CodingKeys: String, CodingKey {
        case customerDetailsID = "customer_details_id"
        case message
        case isNewUser = "is_new_user"
    }
}
