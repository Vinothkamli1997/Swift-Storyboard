//
//  ChangeEmailResponse.swift
//  EliteCake
//
//  Created by TechnoTackle on 05/07/23.
//

import Foundation


// MARK: - VoucherApplyResponse
struct ChangeEmailResponse: Codable {
    let success: Bool
    let message: String
    let parameters: JSONNull?
}
