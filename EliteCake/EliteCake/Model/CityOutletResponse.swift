//
//  CityOutletResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 24/01/23.
//

import Foundation
import UIKit

// MARK: - CityOutletResponse
struct CityOutletResponse: Codable {
    let success: Bool
    let message: String
    let parameters: CityOutletParameters
}

// MARK: - Parameters
struct CityOutletParameters: Codable {
    let outlet_name: [OutletName]
}

// MARK: - OutletName
struct OutletName: Codable {
    let outlet_id, merchant_id, outlet_name, email: String
    let logo: String
    let slogan, longitude, latitude, address: String
    let city, state, mobile, phone: String
    let cp_name: String
    let cp_phone: JSONNull?
    let cp_mobile, cp_email, delivery_radius: String
    let package_id, package_from, package_to, cgst: JSONNull?
    let sgst: JSONNull?
    let pay_mode_cod, p_mode_online, delivery_time, web_link: String
    let fb_link: String
    let insta_link: String
    let menu_id: JSONNull?
    let c_voucher, c_customer_class, c_membership, c_wallet: String
    let open_at, close_at, status, master_copy: String
    let package_status, tax_deduction_prices, dish_selection, dummy_password: String
    let tax, state_code, service_area, uid: String
    let outlet, id: String

//    enum CodingKeys: String, CodingKey {
//        case outletID
//        case merchantID
//        case outletName
//        case email, logo, slogan, longitude, latitude, address, city, state, mobile, phone
//        case cpName
//        case cpPhone
//        case cpMobile
//        case cpEmail
//        case deliveryRadius
//        case packageID
//        case packageFrom
//        case packageTo
//        case cgst, sgst
//        case payModeCod
//        case pModeOnline
//        case deliveryTime
//        case webLink
//        case fbLink
//        case instaLink
//        case menuID
//        case cVoucher
//        case cCustomerClass
//        case cMembership
//        case cWallet
//        case openAt
//        case closeAt
//        case status
//        case masterCopy
//        case packageStatus
//        case taxDeductionPrices
//        case dishSelection
//        case dummyPassword
//        case tax
//        case stateCode
//        case serviceArea
//        case uid, outlet, id
//    }
}
