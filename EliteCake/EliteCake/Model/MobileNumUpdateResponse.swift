//
//  MobileNumUpdateResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 29/05/23.
//

import Foundation

// MARK: - AddFavouriteResponse
struct MobileNumUpdateResponse: Codable {
    let success: Bool
    let message: String
    let parameters: String?
}
