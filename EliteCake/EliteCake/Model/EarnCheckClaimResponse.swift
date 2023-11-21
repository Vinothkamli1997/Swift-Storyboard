//
//  EarnCheckClaimResponse.swift
//  EliteCake
//
//  Created by TechnoTackle on 29/07/23.
//

import Foundation


// MARK: - EarnCheckClaimResponse
struct EarnCheckClaimResponse: Codable {
    let success: Bool
    let message: String
    let parameters: JSONNull?
}
