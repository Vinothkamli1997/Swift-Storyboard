//
//  ApplyReferralResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 03/06/23.
//

import Foundation


// MARK: - ApplyReferralResponse
struct ApplyReferralResponse: Codable {
    let success: Bool
    let message: String
    let parameters: JSONNull?
}
