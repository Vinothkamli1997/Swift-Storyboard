//
//  EarnClaimResponse.swift
//  EliteCake
//
//  Created by TechnoTackle on 31/07/23.
//

import Foundation


// MARK: - EarnClaimResponse
struct EarnClaimResponse: Codable {
    let success: Bool
    let message: String
    let parameters: JSONNull?
}
