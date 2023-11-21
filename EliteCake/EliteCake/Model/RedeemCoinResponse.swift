//
//  RedeemCoinResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 03/05/23.
//

import Foundation

// MARK: - RedeemCoinResponse
struct RedeemCoinResponse: Codable {
    let success: Bool
    let message: String
    let parameters: RedeemParameters?
}

// MARK: - Parameters
struct RedeemParameters: Codable {
    let isSelect: String

    enum CodingKeys: String, CodingKey {
        case isSelect = "is_select"
    }
}
