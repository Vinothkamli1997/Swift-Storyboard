//
//  AddAdressResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 24/04/23.
//

import Foundation


// MARK: - AddAddressResponse
struct AddAddressResponse: Codable {
    let success: Bool
    let message: String
    let parameters: String?
}
