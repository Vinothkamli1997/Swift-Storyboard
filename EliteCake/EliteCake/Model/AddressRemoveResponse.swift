//
//  AddressRemoveResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 26/04/23.
//

import Foundation

// MARK: - AddressRemoveResponse
struct AddressRemoveResponse: Codable {
    let success: Bool
    let message: String
    let parameters: JSONNull?
}
