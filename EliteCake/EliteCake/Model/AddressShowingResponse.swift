//
//  AddressShowingResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 24/04/23.
//

import Foundation


// MARK: - AddressShowingResponse
struct AddressShowingResponse: Codable {
    let success: Bool
    let message: String
    let parameters: AddressShowingParameters
}

// MARK: - Parameters
struct AddressShowingParameters: Codable {
    let address: [Address]
}

// MARK: - Address
struct Address: Codable {
    let customerAddressID, customerID, type: String
    let houseNo: String
    let area: String
    let description: JSONNull?
    let latitude, longitude, name: String
    let mobile: String
    let addressDefault: String

    enum CodingKeys: String, CodingKey {
        case customerAddressID = "customer_address_id"
        case customerID = "customer_id"
        case type
        case houseNo = "house_no"
        case area, description, latitude, longitude, name, mobile
        case addressDefault = "default"
    }
}
