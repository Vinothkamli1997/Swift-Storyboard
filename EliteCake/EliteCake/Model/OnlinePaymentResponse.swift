//
//  OnlinePaymentResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 28/04/23.
//

import Foundation


// MARK: - OnlinePaymntResponse
struct OnlinePaymntResponse: Codable {
    let success: Bool
    let message: String
    let parameters: OnlinePaymentParameters?
}

// MARK: - Parameters
struct OnlinePaymentParameters: Codable {
    let cart: PaymentCart
    let transactionID: String

    enum CodingKeys: String, CodingKey {
        case cart
        case transactionID = "transaction_id"
    }
}

// MARK: - Cart
struct PaymentCart: Codable {
    let cartID, customerID: String?
    let deliveryTime: String?
    let amountPayable, amount: String?
    let payMode, deliveryMode, delPerson: String?
    let orderTime: String?
    let voucherID, voucherDiscount: String?
    let merchantDetailsMerchantID, uid, status: String
    let address, radius, alreadyRec, recieveNow: String?
    let customerName, customerAddress, customerMobile, addressTitle: String?
    let addonCost, superCoin, superCoinAmount, delAmt: String
    let delType, delSlot, cakeCutTime, specialInstruction: String
    let birthday: String

    enum CodingKeys: String, CodingKey {
        case cartID = "cart_id"
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
        case uid, status, address, radius
        case alreadyRec = "already_rec"
        case recieveNow = "recieve_now"
        case customerName = "customer_name"
        case customerAddress = "customer_address"
        case customerMobile = "customer_mobile"
        case addressTitle = "address_title"
        case addonCost = "addon_cost"
        case superCoin = "super_coin"
        case superCoinAmount = "super_coin_amount"
        case delAmt = "del_amt"
        case delType = "del_type"
        case delSlot = "del_slot"
        case cakeCutTime = "cake_cut_time"
        case specialInstruction = "special_instruction"
        case birthday
    }
}

