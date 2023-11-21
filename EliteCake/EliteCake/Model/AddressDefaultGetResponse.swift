//
//  AddressDefaultGetResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 26/04/23.
//

import Foundation

// MARK: - AddressDefaultGetResponse
struct AddressDefaultGetResponse: Codable {
    let success: Bool
    let message: String
    let parameters: AddressDefaultGetParameters?
}

// MARK: - Parameters
struct AddressDefaultGetParameters: Codable {
    let customerAddressID, customerID, type, houseNo: String
    let area: String
    let description: String?
    let latitude, longitude, name, mobile: String
    let parametersDefault: String

    enum CodingKeys: String, CodingKey {
        case customerAddressID = "customer_address_id"
        case customerID = "customer_id"
        case type
        case houseNo = "house_no"
        case area, description, latitude, longitude, name, mobile
        case parametersDefault = "default"
    }
}
