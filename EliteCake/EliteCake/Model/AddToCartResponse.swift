//
//  AddToCartResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 03/04/23.
//

import Foundation

// MARK: - AddCartToResponse
struct AddToCartResponse: Codable {
    let success: Bool
    let message: String
    let parameters: Int?
}
