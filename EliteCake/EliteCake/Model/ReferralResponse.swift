//
//  ReferralResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 25/05/23.
//

import Foundation

// MARK: - ReferralResponse
struct ReferralResponse: Codable {
    let success: Bool
    let message: String
    let parameters: ReferralParameters
}

// MARK: - Parameters
struct ReferralParameters: Codable {
    let referalCode: ReferalCode

    enum CodingKeys: String, CodingKey {
        case referalCode = "referal_code"
    }
}

// MARK: - ReferalCode
struct ReferalCode: Codable {
}
