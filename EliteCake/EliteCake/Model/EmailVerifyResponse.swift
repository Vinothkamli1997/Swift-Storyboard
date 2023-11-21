//
//  EmailVerifyResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 31/05/23.
//

import Foundation



// MARK: - EmailVerifyResponse
struct EmailVerifyResponse: Codable {
    let success: Bool
    let message: String
    let parameters: EmailVerifyParameters?
}

// MARK: - Parameters
struct EmailVerifyParameters: Codable {
    let customerID: String

    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
    }
}
