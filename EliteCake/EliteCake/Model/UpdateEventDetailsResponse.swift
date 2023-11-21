//
//  UpdateEventDetailsResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 09/06/23.
//

import Foundation

// MARK: - UpdateEventDetailsResponse
struct UpdateEventDetailsResponse: Codable {
    let success: Bool
    let message: String
    let parameters: JSONNull?
}
