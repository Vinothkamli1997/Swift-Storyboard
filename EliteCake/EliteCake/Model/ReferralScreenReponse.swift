//
//  ReferralScreenReponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 02/06/23.
//

import Foundation


// MARK: - ReferralResponse
struct ReferralScreenResponse: Codable {
    let success: Bool
    let message: String
    let parameters: ReferralScreenParameters
}

// MARK: - Parameters
struct ReferralScreenParameters: Codable {
    let referalCode: String

    enum CodingKeys: String, CodingKey {
        case referalCode = "referal_code"
    }
}
