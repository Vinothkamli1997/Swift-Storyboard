//
//  AddFavouriteResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 16/02/23.
//

import Foundation

// MARK: - AddFavouriteResponse
struct AddFavouriteResponse: Codable {
    let success: Bool
    let message: String
    let parameters: AddFavouriteParameters?
}

// MARK: - Parameters
struct AddFavouriteParameters: Codable {
    let customerID, dishID, merchantID: String
    let foodFavoriteID: Int

    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
        case dishID = "dish_id"
        case merchantID = "merchant_id"
        case foodFavoriteID = "food_favorite_id"
    }
}

