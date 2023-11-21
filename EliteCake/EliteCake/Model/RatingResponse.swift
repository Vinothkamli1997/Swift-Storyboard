//
//  RatingResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 07/06/23.
//

import Foundation


// MARK: - RatingResponse
struct RatingResponse: Codable {
    let success: Bool
    let message: String
    let parameters: MyValue?
}
