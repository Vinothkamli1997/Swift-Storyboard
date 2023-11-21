//
//  CityResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 23/01/23.
//

import Foundation
import UIKit


//// MARK: - CityResponse
//struct CityResponse: Codable {
//    let success: Bool
//    let message: String
//    let parameters: CityParameters
//}
//
//// MARK: - Parameters
//struct CityParameters: Codable {
//    let city: [City]
//}
//
//// MARK: - City
//struct City: Codable {
//    let outlet_id, merchant_id, outlet_name, email: String
//    let logo: String
//    let slogan, longitude, latitude, address: String
//    let city, state, mobile, phone: String
//    let cp_name: String
//    let cp_phone: String?
//    let cp_mobile, cp_email, delivery_radius: String
//    let package_id, package_from, package_to, cgst: String?
//    let sgst: String?
//    let pay_mode_cod, p_mode_online, delivery_time, web_link: String
//    let fb_link: String
//    let insta_link: String
//    let menu_id: String?
//    let c_voucher, c_customer_class, c_membership, c_wallet: String
//    let open_at, close_at, status, master_copy: String
//    let package_status, tax_deduction_prices, dish_selection, dummy_password: String
//    let tax, state_code, service_area, uid: String
//    let id: String
//}
//
//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}


// MARK: - CityResponse
struct CityResponse: Codable {
    let success: Bool
    let message: String
    let parameters: CityParameters
}

// MARK: - Parameters
struct CityParameters: Codable {
    let city: [City]
}

// MARK: - City
struct City: Codable {
    let outletID, merchantID, outletName, email: String?
    let logo: String?
    let slogan, longitude, latitude, address: String?
    let city, state, mobile, phone: String?
    let cpName: String?
    let cpPhone: String?
    let cpMobile, cpEmail, deliveryRadius: String
    let packageID, packageFrom, packageTo, cgst: String?
    let sgst: String?
    let payModeCod, pModeOnline, deliveryTime, webLink: String?
    let fbLink, instaLink: String?
    let menuID: String?
    let cVoucher, cCustomerClass, cMembership, cWallet: String?
    let openAt, closeAt, status, masterCopy: String?
    let packageStatus, taxDeductionPrices, dishSelection, dummyPassword: String?
    let tax, stateCode, serviceArea, uid: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case outletID = "outlet_id"
        case merchantID = "merchant_id"
        case outletName = "outlet_name"
        case email, logo, slogan, longitude, latitude, address, city, state, mobile, phone
        case cpName = "cp_name"
        case cpPhone = "cp_phone"
        case cpMobile = "cp_mobile"
        case cpEmail = "cp_email"
        case deliveryRadius = "delivery_radius"
        case packageID = "package_id"
        case packageFrom = "package_from"
        case packageTo = "package_to"
        case cgst, sgst
        case payModeCod = "pay_mode_cod"
        case pModeOnline = "p_mode_online"
        case deliveryTime = "delivery_time"
        case webLink = "web_link"
        case fbLink = "fb_link"
        case instaLink = "insta_link"
        case menuID = "menu_id"
        case cVoucher = "c_voucher"
        case cCustomerClass = "c_customer_class"
        case cMembership = "c_membership"
        case cWallet = "c_wallet"
        case openAt = "open_at"
        case closeAt = "close_at"
        case status
        case masterCopy = "master_copy"
        case packageStatus = "package_status"
        case taxDeductionPrices = "tax_deduction_prices"
        case dishSelection = "dish_selection"
        case dummyPassword = "dummy_password"
        case tax
        case stateCode = "state_code"
        case serviceArea = "service_area"
        case uid, id
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
