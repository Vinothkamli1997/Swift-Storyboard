//
//  FilterCheckResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 03/03/23.
//

import Foundation

// MARK: - FilterChackResponse
struct FilterCheckResponse: Codable {
    let success: Bool
    let message: String
    let parameters: JSONNull?
}
