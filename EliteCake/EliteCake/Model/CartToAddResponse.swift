//
//  CartToAddResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 28/04/23.
//

import Foundation

// MARK: - CartToAddResponse
struct CartToAddResponse: Codable {
    let success: Bool
    let message: String
    let parameters: CartToAddParameters?
}


// MARK: - Parameters
struct CartToAddParameters: Codable {
    let orderID: Int

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
    }
}
