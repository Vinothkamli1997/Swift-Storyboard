//
//  OrderSumaryResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 18/05/23.
//

import Foundation

// MARK: - OrderSummaryResponse
struct OrderSummaryResponse: Codable {
    let success: Bool
    let message: String
    let parameters: OrderSummaryParameters
}

// MARK: - Parameters
struct OrderSummaryParameters: Codable {
    let orderHistory: [OrderSummaryOrderHistory]
    let orderStatus: [OrderSummaryOrderStatus]
    let customerDetails: OrderSummaryCustomerDetails?
    let outletDetails: OrderSummaryOutletDetails
    let outletDeliveryType: [OrderSummaryOutletDeliveryType]
    let outletSlot: [OrderSummartOutletSlot]

    enum CodingKeys: String, CodingKey {
        case orderHistory = "order_history"
        case orderStatus = "order_status"
        case customerDetails = "customer_details"
        case outletDetails = "outlet_details"
        case outletDeliveryType = "outlet_delivery_type"
        case outletSlot = "outlet_slot"
    }
}

// MARK: - CustomerDetails
struct OrderSummaryCustomerDetails: Codable {
    let customerDetailsID, customerName, customerMobile: String
    let username: String?
    let loginWith: String
    let dateOfActivation: String?
    let merchantDetailsMerchantID, uid: String?
    let membershipID: String?
    let status, created, updated: String
    let password, membership: String?
    let action, customerAddress, customerEmail: String?
    let socialID, response: String?
    let otp, customeImage, dateOfBirth, referalCode: String?
    let usedReferalCode, isProfileCompleted, isReferalCoinAdded, lastLoginTime: String?
    let isForceLogOut, lastForceLogOut, customerAddressID, customerID: String?
    let type, houseNo, area: String?
    let description: String?
    let latitude, longitude, name, mobile: String?
    let customerDetailsDefault: String?

    enum CodingKeys: String, CodingKey {
        case customerDetailsID = "customer_details_id"
        case customerName = "customer_name"
        case customerMobile = "customer_mobile"
        case username
        case loginWith = "login_with"
        case dateOfActivation = "date_of_activation"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
        case membershipID = "membership_id"
        case status, created, updated, password, membership, action
        case customerAddress = "customer_address"
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
        case isForceLogOut = "is_force_log_out"
        case lastForceLogOut = "last_force_log_out"
        case customerAddressID = "customer_address_id"
        case customerID = "customer_id"
        case type
        case houseNo = "house_no"
        case area, description, latitude, longitude, name, mobile
        case customerDetailsDefault = "default"
    }
}

// MARK: - OrderHistory
struct OrderSummaryOrderHistory: Codable {
    let orderID, id, customerID: String?
    let deliveryTime: String?
    let amountPayable, amount, payMode, deliveryMode: String?
    let delPerson: String?
    let orderTime: String?
    let voucherID, voucherDiscount: String?
    let merchantDetailsMerchantID, uid, status, time: String?
    let date: String?
    let address, radius, alreadyRec, recieveNow: String?
    let customerMobile: String?
    let addressTitle: String?
    let customerAddress, customerName: String?
    let houseNo, area, description, latitude: String?
    let longitude, mobile, transactionID, cookingTime: String?
    let addonCost: String?
    let reason: String?
    let superCoin, superCoinAmount, delAmt, delType: String?
    let delSlot, cakeCutTime, specialInstruction, birthday: String?
    let customerAddressID: String?
    let orderHasDishDetails: [OrderSummaryOrderHasDishDetail]
    let canVoucherApply, canCoinApply: Int?

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
        case customerAddressID = "customer_address_id"
        case orderHasDishDetails
        case canVoucherApply = "can_voucher_apply"
        case canCoinApply = "can_coin_apply"
    }
}

// MARK: - OrderHasDishDetail
struct OrderSummaryOrderHasDishDetail: Codable {
    let orderDishID, orderOrderID, dishDetailsDishID, quantity: String?
    let orderAmount, created, updated, size: String?
    let orderDishAmount: String?
    let voucherDiscount: String?
    let cookingTime, statusbykitchen, reason, cookingStartTime: String?
    let dishID, dishDetailsID, dishName, dishImage: String?
    let cuisineID, timeAll, categoryID, dishType: String?
    let unitID: String?
    let customSize, sizeID, serves: String?
    let status, dishPrice, dishDiscounts, dishCreated: String?
    let dishUpdated, dishAvailability, merchantDetailsMerchantID, uid: String?
    let description, discountPercentage, dishOnorder, deliveryTime: String?
    let deliveryMin, deliveryHours, descriptionShow, billingid: String?
    let dishSelection, additionalImage, additionalImage2, withBackground: String?
    let descriptiveImage, customerApplicableClass, avalPickup, dishRating: String?
    let isCustomized, isSlotRestriction, landingPrice, priceDetails: String?
    let category: OrderSummaryCategory
//    let addon: [JSONAny]
    let addon: [TrackAddon]?

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
        case cookingStartTime = "cooking_start_time"
        case dishID = "dish_id"
        case dishDetailsID = "dish_details_id"
        case dishName = "dish_name"
        case dishImage = "dish_image"
        case cuisineID = "cuisine_id"
        case timeAll = "time_all"
        case categoryID = "category_id"
        case dishType = "dish_type"
        case unitID = "unit_id"
        case customSize = "custom_size"
        case sizeID = "size_id"
        case serves, status
        case dishPrice = "dish_price"
        case dishDiscounts = "dish_discounts"
        case dishCreated = "dish_created"
        case dishUpdated = "dish_updated"
        case dishAvailability = "dish_availability"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid, description
        case discountPercentage = "discount_percentage"
        case dishOnorder = "dish_onorder"
        case deliveryTime = "delivery_time"
        case deliveryMin = "delivery_min"
        case deliveryHours = "delivery_hours"
        case descriptionShow = "description_show"
        case billingid
        case dishSelection = "dish_selection"
        case additionalImage = "additional_image"
        case additionalImage2 = "additional_image_2"
        case withBackground = "With_background"
        case descriptiveImage = "Descriptive_Image"
        case customerApplicableClass = "customer_applicable_class"
        case avalPickup = "aval_pickup"
        case dishRating = "dish_rating"
        case isCustomized = "is_customized"
        case isSlotRestriction = "is_slot_restriction"
        case landingPrice = "landing_price"
        case priceDetails = "price_details"
        case category, addon
    }
}

// MARK: - Category
struct OrderSummaryCategory: Codable {
    let categoryID, categoryName, categoryImage, categoryStatus: String?
    let categoryCreated, categoryUpdated, merchantDetailsMerchantID, uid: String?
    let categorySequenceNo: String?

    enum CodingKeys: String, CodingKey {
        case categoryID = "category_id"
        case categoryName = "category_name"
        case categoryImage = "category_image"
        case categoryStatus = "category_status"
        case categoryCreated = "category_created"
        case categoryUpdated = "category_updated"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
        case categorySequenceNo = "category_sequence_no"
    }
}

// MARK: - OrderStatus
struct OrderSummaryOrderStatus: Codable {
    let status, msg, ordertime, date: String
}

// MARK: - OutletDeliveryType
struct OrderSummaryOutletDeliveryType: Codable {
    let deliveryID, outletDetailsID, deliverytype, addedDate: String?

    enum CodingKeys: String, CodingKey {
        case deliveryID = "delivery_id"
        case outletDetailsID = "outlet_details_id"
        case deliverytype
        case addedDate = "added_date"
    }
}

// MARK: - OutletDetails
struct OrderSummaryOutletDetails: Codable {
    let outletID, merchantID, outletName, email: String?
    let logo: String?
    let slogan, longitude, latitude, address: String?
    let city, state, mobile, phone: String?
    let cpName: String
    let cpPhone: String?
    let cpMobile, cpEmail, deliveryRadius: String
    let packageID, packageFrom, packageTo, cgst: String?
    let sgst: String?
    let payModeCod, pModeOnline, deliveryTime, webLink: String?
    let fbLink: String?
    let instaLink: String?
    let menuID: String?
    let cVoucher, cCustomerClass, cMembership, cWallet: String?
    let openAt, closeAt, status, masterCopy: String?
    let packageStatus, taxDeductionPrices, dishSelection, dummyPassword: String?
    let tax, stateCode, serviceArea, uid: String?

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
        case uid
    }
}

// MARK: - OutletSlot
struct OrderSummartOutletSlot: Codable {
    let deliverySlotID, deliverySlotName, outletID, uid: String?
    let addedDate, from, to: String?

    enum CodingKeys: String, CodingKey {
        case deliverySlotID = "delivery_slot_id"
        case deliverySlotName = "delivery_slot_name"
        case outletID = "outlet_id"
        case uid
        case addedDate = "added_date"
        case from, to
    }
}

// MARK: - Addon
struct TrackAddon: Codable {
    let orderDishHasAddonID, orderID, dishID, addonID: String?
    let merchantID, uid: String?
    let addonCart: TrackAddonCart

    enum CodingKeys: String, CodingKey {
        case orderDishHasAddonID = "order_dish_has_addon_id"
        case orderID = "order_id"
        case dishID = "dish_id"
        case addonID = "addon_id"
        case merchantID = "merchant_id"
        case uid
        case addonCart = "addon_cart"
    }
}

// MARK: - AddonCart
struct TrackAddonCart: Codable {
    let addonID, addonCategoryID, addonName, addonSize: String?
    let addonPrice, addonStatus, merchantDetailsMerchantID, uid: String?
    let addonImage, sequenceNo: String?

    enum CodingKeys: String, CodingKey {
        case addonID = "addon_id"
        case addonCategoryID = "addon_category_id"
        case addonName = "addon_name"
        case addonSize = "addon_size"
        case addonPrice = "addon_price"
        case addonStatus = "addon_status"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
        case addonImage = "addon_image"
        case sequenceNo = "sequence_no"
    }
}

