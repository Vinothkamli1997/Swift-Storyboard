//
//  MobileNumberUpdateResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 30/05/23.
//

import Foundation

// MARK: - MobileNumberUpdateResponse
struct MobileNumberUpdateResponse: Codable {
    let success: Bool
    let message: String
    let parameters: MobileNumberUpdateParameters?
}

// MARK: - Parameters
struct MobileNumberUpdateParameters: Codable {
    let customerID: String

    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
    }
}

