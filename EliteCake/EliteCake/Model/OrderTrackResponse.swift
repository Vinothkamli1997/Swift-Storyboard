//
//  OrderTrackResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 10/05/23.
//

import Foundation

// MARK: - OrderTrackResponse
struct OrderTrackResponse: Codable {
    let success: Bool
    let message: String
    let parameters: OrderTrackParameters
}

// MARK: - Parameters
struct OrderTrackParameters: Codable {
    let orderHistory: [OrderHistory]
    let orderStatus: [TrackOrderStatus]
    let driverlocation: String?

    enum CodingKeys: String, CodingKey {
        case orderHistory = "order_history"
        case orderStatus = "order_status"
        case driverlocation
    }
}

// MARK: - OrderHistory
struct OrderHistory: Codable {
    let orderID, id, customerID: String?
    let deliveryTime: String?
    let amountPayable, amount, payMode, deliveryMode: String?
    let delPerson: String?
    let orderTime: String?
    let voucherID, voucherDiscount: String?
    let merchantDetailsMerchantID, uid, status, time: String?
    let date, address: String?
    let radius, alreadyRec, recieveNow: String?
    let customerMobile: String?
    let addressTitle: String?
    let customerAddress, customerName, houseNo, area: String?
    let description: String?
    let latitude, longitude, mobile: String?
    let transactionID, cookingTime: String?
    let addonCost: String?
    let reason: String?
    let superCoin, superCoinAmount, delAmt, delType: String?
    let delSlot, cakeCutTime, specialInstruction, birthday: String?
    let outletLat, outletLong, currentStatus, customerDetailsID: String?
    let username: String?
    let loginWith: String?
    let dateOfActivation, membershipID: String?
    let created, updated: String?
    let password, membership: String?
    let action, customerEmail: String?
    let socialID, response: String?
    let otp, customeImage, dateOfBirth, referalCode: String?
    let usedReferalCode, isProfileCompleted, isReferalCoinAdded, lastLoginTime: String?
    let customerAddressID, type, name, orderHistoryDefault: String?
    let customerLat, customerLong, outletID, merchantID: String?
    let outletName, email: String?
    let logo: String?
    let slogan, city, state, phone: String?
    let cpName: String?
    let cpPhone: String?
    let cpMobile, cpEmail, deliveryRadius: String?
    let packageID, packageFrom, packageTo, cgst: String?
    let sgst: String?
    let payModeCod, pModeOnline, webLink: String?
    let fbLink: String?
    let instaLink: String?
    let menuID: String?
    let cVoucher, cCustomerClass, cMembership, cWallet: String?
    let openAt, closeAt, masterCopy, packageStatus: String?
    let taxDeductionPrices, dishSelection, dummyPassword, tax: String?
    let stateCode, serviceArea: String?
    let orderHasDishDetails: [TrackOrderHasDishDetail]

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case id
        case customerID = "customer_id"
        case deliveryTime = "delivery_time"
        case amountPayable = "amount_payable"
        case amount
        case payMode = "pay_mode"
        case deliveryMode = "delivery_mode"
        case delPerson = "del_person"
        case orderTime = "order_time"
        case voucherID = "voucher_id"
        case voucherDiscount = "voucher_discount"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid, status, time, date, address, radius
        case alreadyRec = "already_rec"
        case recieveNow = "recieve_now"
        case customerMobile = "customer_mobile"
        case addressTitle = "address_title"
        case customerAddress = "customer_address"
        case customerName = "customer_name"
        case houseNo = "house_no"
        case area, description, latitude, longitude, mobile
        case transactionID = "transaction_id"
        case cookingTime = "cooking_time"
        case addonCost = "addon_cost"
        case reason
        case superCoin = "super_coin"
        case superCoinAmount = "super_coin_amount"
        case delAmt = "del_amt"
        case delType = "del_type"
        case delSlot = "del_slot"
        case cakeCutTime = "cake_cut_time"
        case specialInstruction = "special_instruction"
        case birthday
        case outletLat = "outlet_lat"
        case outletLong = "outlet_long"
        case currentStatus = "current_status"
        case customerDetailsID = "customer_details_id"
        case username
        case loginWith = "login_with"
        case dateOfActivation = "date_of_activation"
        case membershipID = "membership_id"
        case created, updated, password, membership, action
        case customerEmail = "customer_email"
        case socialID = "social_id"
        case response, otp
        case customeImage = "custome_image"
        case dateOfBirth = "date_of_birth"
        case referalCode = "referal_code"
        case usedReferalCode = "used_referal_code"
        case isProfileCompleted = "is_profile_completed"
        case isReferalCoinAdded = "is_referal_coin_added"
        case lastLoginTime = "last_login_time"
        case customerAddressID = "customer_address_id"
        case type, name
        case orderHistoryDefault = "default"
        case customerLat = "customer_lat"
        case customerLong = "customer_long"
        case outletID = "outlet_id"
        case merchantID = "merchant_id"
        case outletName = "outlet_name"
        case email, logo, slogan, city, state, phone
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
        case masterCopy = "master_copy"
        case packageStatus = "package_status"
        case taxDeductionPrices = "tax_deduction_prices"
        case dishSelection = "dish_selection"
        case dummyPassword = "dummy_password"
        case tax
        case stateCode = "state_code"
        case serviceArea = "service_area"
        case orderHasDishDetails
    }
}

// MARK: - OrderHasDishDetail
struct TrackOrderHasDishDetail: Codable {
    let orderDishID, orderOrderID, dishDetailsDishID, quantity: String?
    let orderAmount, created, updated, size: String?
    let orderDishAmount: String?
    let voucherDiscount: String?
    let cookingTime: String?
    let statusbykitchen, reason, dishName: String?

    enum CodingKeys: String, CodingKey {
        case orderDishID = "order_dish_id"
        case orderOrderID = "order_order_id"
        case dishDetailsDishID = "dish_details_dish_id"
        case quantity
        case orderAmount = "order_amount"
        case created, updated, size
        case orderDishAmount = "order_dish_amount"
        case voucherDiscount = "voucher_discount"
        case cookingTime = "cooking_time"
        case statusbykitchen, reason
        case dishName = "dish_name"
    }
}

// MARK: - OrderStatus
struct TrackOrderStatus: Codable {
    let status, ordertime, date, msg: String?
}
