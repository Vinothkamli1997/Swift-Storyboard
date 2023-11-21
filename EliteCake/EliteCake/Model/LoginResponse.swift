//
//  LoginResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 06/01/23.
//

import UIKit

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let success: Bool
    let message: String
    let parameters: Parameters?
}

// MARK: - Parameters
struct Parameters: Codable {
    let is_new_user: Int
    let customer_details_id: Int?
    let message: String
}
