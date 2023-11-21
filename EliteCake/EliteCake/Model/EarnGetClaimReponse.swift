//
//  EarnGetClaimReponse.swift
//  EliteCake
//
//  Created by TechnoTackle on 29/07/23.
//

import Foundation


// MARK: - EarnGetClaimResponse
struct EarnGetClaimResponse: Codable {
    let success: Bool
    let message: String
    let parameters: [EarnGetParameter]
}

// MARK: - Parameter
struct EarnGetParameter: Codable {
    let rangeID, from, to, amount: String
    let merchantID, createdAt, updatedAt: String
    let addMoreShow, addMore, claimButton: Int

    enum CodingKeys: String, CodingKey {
        case rangeID = "range_id"
        case from, to, amount
        case merchantID = "merchant_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case addMoreShow = "add_more_show"
        case addMore = "add_more"
        case claimButton = "claim_button"
    }
}
