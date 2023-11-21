//
//  CartShowingResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 04/04/23.
//

import Foundation

//// MARK: - CartShowingResponse
//struct CartShowingResponse: Codable {
//    let success: Bool
//    let message: String
//    let parameters: CartShowingParameters
//}
//
//// MARK: - Parameters
//struct CartShowingParameters: Codable {
//    let cart: [Cart]
//    let totalItems: Int
//    let fixedTags: FixedTags
//    let outletDetails: OutletDetails
//    let outletDeliveryType: [OutletDeliveryType]
//    let outletSlot: [OutletSlot]
//
//    enum CodingKeys: String, CodingKey {
//        case cart
//        case totalItems = "total_items"
//        case fixedTags = "fixed_tags"
//        case outletDetails = "outlet_details"
//        case outletDeliveryType = "outlet_delivery_type"
//        case outletSlot = "outlet_slot"
//    }
//}
//
//// MARK: - Cart
//struct Cart: Codable {
//    let cartID, customerID: String
//    let deliveryTime: String?
//    let amountPayable, amount: String
//    let payMode, deliveryMode, delPerson: String?
//    let orderTime: String
//    let voucherID, voucherDiscount: String?
//    let merchantDetailsMerchantID, uid, status: String
//    let address, radius, alreadyRec, recieveNow: String?
//    let customerName, customerAddress, customerMobile, addressTitle: String?
//    let addonCost, superCoin, superCoinAmount, delAmt: String
//    let delType, delSlot, cakeCutTime, specialInstruction: String
//    let birthday: String
//    var cartHasDishDetails: [CartHasDishDetail]
//    let cartHasDishaddon: [Addon]
//    let canVoucherApply, canCoinApply, isVoucherApplied, isCoinApplied: Int
//    let isCoinSelect: Int
//
//    enum CodingKeys: String, CodingKey {
//        case cartID = "cart_id"
//        case customerID = "customer_id"
//        case deliveryTime = "delivery_time"
//        case amountPayable = "amount_payable"
//        case amount
//        case payMode = "pay_mode"
//        case deliveryMode = "delivery_mode"
//        case delPerson = "del_person"
//        case orderTime = "order_time"
//        case voucherID = "voucher_id"
//        case voucherDiscount = "voucher_discount"
//        case merchantDetailsMerchantID = "merchant_details_merchant_id"
//        case uid, status, address, radius
//        case alreadyRec = "already_rec"
//        case recieveNow = "recieve_now"
//        case customerName = "customer_name"
//        case customerAddress = "customer_address"
//        case customerMobile = "customer_mobile"
//        case addressTitle = "address_title"
//        case addonCost = "addon_cost"
//        case superCoin = "super_coin"
//        case superCoinAmount = "super_coin_amount"
//        case delAmt = "del_amt"
//        case delType = "del_type"
//        case delSlot = "del_slot"
//        case cakeCutTime = "cake_cut_time"
//        case specialInstruction = "special_instruction"
//        case birthday, cartHasDishDetails, cartHasDishaddon
//        case canVoucherApply = "can_voucher_apply"
//        case canCoinApply = "can_coin_apply"
//        case isVoucherApplied = "is_voucher_applied"
//        case isCoinApplied = "is_coin_applied"
//        case isCoinSelect = "is_coin_select"
//    }
//}
//
//// MARK: - CartHasDishDetail
//struct CartHasDishDetail: Codable {
//    var cartHasDishID, cartCartID, dishDetailsDishID: String?
//    let quantity: String?
//    let orderAmount, created, updated, size: String?
//    let cartDishAmount: String?
//    let voucherDiscount: String?
//    let dishID, dishDetailsID, dishName, dishImage: String?
//    let cuisineID, timeAll, categoryID, dishType: String?
//    let unitID: String?
//    let customSize, sizeID, serves: String?
//    let status, dishDiscounts, dishCreated: String?
//    let dishPrice: String?
//    let dishUpdated, dishAvailability, merchantDetailsMerchantID, uid: String?
//    let description, discountPercentage, dishOnorder, deliveryTime: String?
//    let deliveryMin, deliveryHours, descriptionShow, billingid: String?
//    let dishSelection, additionalImage, additionalImage2, withBackground: String?
//    let descriptiveImage: String?
//    let customerApplicableClass, cookingTime, avalPickup: String?
//    let dishRating, isCustomized, isSlotRestriction, landingPrice: String?
//    let priceDetails: String?
//    let category: Category
//    let addon: [Addon]
//
//    enum CodingKeys: String, CodingKey {
//        case cartHasDishID = "Cart_has_dish_id"
//        case cartCartID = "Cart_cart_id"
//        case dishDetailsDishID = "dish_details_dish_id"
//        case quantity
//        case orderAmount = "order_amount"
//        case created, updated, size
//        case cartDishAmount = "cart_dish_amount"
//        case voucherDiscount = "voucher_discount"
//        case dishID = "dish_id"
//        case dishDetailsID = "dish_details_id"
//        case dishName = "dish_name"
//        case dishImage = "dish_image"
//        case cuisineID = "cuisine_id"
//        case timeAll = "time_all"
//        case categoryID = "category_id"
//        case dishType = "dish_type"
//        case unitID = "unit_id"
//        case customSize = "custom_size"
//        case sizeID = "size_id"
//        case serves, status
//        case dishPrice = "dish_price"
//        case dishDiscounts = "dish_discounts"
//        case dishCreated = "dish_created"
//        case dishUpdated = "dish_updated"
//        case dishAvailability = "dish_availability"
//        case merchantDetailsMerchantID = "merchant_details_merchant_id"
//        case uid, description
//        case discountPercentage = "discount_percentage"
//        case dishOnorder = "dish_onorder"
//        case deliveryTime = "delivery_time"
//        case deliveryMin = "delivery_min"
//        case deliveryHours = "delivery_hours"
//        case descriptionShow = "description_show"
//        case billingid
//        case dishSelection = "dish_selection"
//        case additionalImage = "additional_image"
//        case additionalImage2 = "additional_image_2"
//        case withBackground = "With_background"
//        case descriptiveImage = "Descriptive_Image"
//        case customerApplicableClass = "customer_applicable_class"
//        case cookingTime = "cooking_time"
//        case avalPickup = "aval_pickup"
//        case dishRating = "dish_rating"
//        case isCustomized = "is_customized"
//        case isSlotRestriction = "is_slot_restriction"
//        case landingPrice = "landing_price"
//        case priceDetails = "price_details"
//        case category, addon
//    }
//}
//
//// MARK: - FixedTags
//struct FixedTags: Codable {
//    let fixedTag, msg: String
//
//    enum CodingKeys: String, CodingKey {
//        case fixedTag = "fixed_tag"
//        case msg
//    }
//}
//
//// MARK: - OutletDeliveryType
//struct OutletDeliveryType: Codable {
//    let deliveryID, outletDetailsID, deliverytype, addedDate: String
//
//    enum CodingKeys: String, CodingKey {
//        case deliveryID = "delivery_id"
//        case outletDetailsID = "outlet_details_id"
//        case deliverytype
//        case addedDate = "added_date"
//    }
//}
//
//// MARK: - OutletDetails
//struct OutletDetails: Codable {
//    let outletID, merchantID, outletName, email: String
//    let logo: String
//    let slogan, longitude, latitude, address: String
//    let city, state, mobile, phone: String
//    let cpName: String
//    let cpPhone: String?
//    let cpMobile, cpEmail, deliveryRadius: String
//    let packageID, packageFrom, packageTo, cgst: String?
//    let sgst: String?
//    let payModeCod, pModeOnline, deliveryTime, webLink: String
//    let fbLink: String
//    let instaLink: String
//    let menuID: String?
//    let cVoucher, cCustomerClass, cMembership, cWallet: String
//    let openAt, closeAt, status, masterCopy: String
//    let packageStatus, taxDeductionPrices, dishSelection, dummyPassword: String
//    let tax, stateCode, serviceArea, uid: String
//
//    enum CodingKeys: String, CodingKey {
//        case outletID = "outlet_id"
//        case merchantID = "merchant_id"
//        case outletName = "outlet_name"
//        case email, logo, slogan, longitude, latitude, address, city, state, mobile, phone
//        case cpName = "cp_name"
//        case cpPhone = "cp_phone"
//        case cpMobile = "cp_mobile"
//        case cpEmail = "cp_email"
//        case deliveryRadius = "delivery_radius"
//        case packageID = "package_id"
//        case packageFrom = "package_from"
//        case packageTo = "package_to"
//        case cgst, sgst
//        case payModeCod = "pay_mode_cod"
//        case pModeOnline = "p_mode_online"
//        case deliveryTime = "delivery_time"
//        case webLink = "web_link"
//        case fbLink = "fb_link"
//        case instaLink = "insta_link"
//        case menuID = "menu_id"
//        case cVoucher = "c_voucher"
//        case cCustomerClass = "c_customer_class"
//        case cMembership = "c_membership"
//        case cWallet = "c_wallet"
//        case openAt = "open_at"
//        case closeAt = "close_at"
//        case status
//        case masterCopy = "master_copy"
//        case packageStatus = "package_status"
//        case taxDeductionPrices = "tax_deduction_prices"
//        case dishSelection = "dish_selection"
//        case dummyPassword = "dummy_password"
//        case tax
//        case stateCode = "state_code"
//        case serviceArea = "service_area"
//        case uid
//    }
//}
//
//// MARK: - OutletSlot
//struct OutletSlot: Codable {
//    let deliverySlotID, deliverySlotName, outletID, uid: String
//    let addedDate, from, to: String
//
//    enum CodingKeys: String, CodingKey {
//        case deliverySlotID = "delivery_slot_id"
//        case deliverySlotName = "delivery_slot_name"
//        case outletID = "outlet_id"
//        case uid
//        case addedDate = "added_date"
//        case from, to
//    }
//}
//
//// MARK: - Addon
//struct Addon: Codable {
//    let cartDishHasAddonID, cartID, dishID, addonID: String
//    let merchantID, uid: String
//    let addonCart: AddonCart?
//
//    enum CodingKeys: String, CodingKey {
//        case cartDishHasAddonID = "cart_dish_has_addon_id"
//        case cartID = "cart_id"
//        case dishID = "dish_id"
//        case addonID = "addon_id"
//        case merchantID = "merchant_id"
//        case uid
//        case addonCart = "addon_cart"
//    }
//}
//
//// MARK: - AddonCart
//struct AddonCart: Codable {
//    let addonID, addonCategoryID, addonName, addonSize: String
//    let addonPrice, addonStatus, merchantDetailsMerchantID, uid: String
//    let addonImage, sequenceNo: String
//
//    enum CodingKeys: String, CodingKey {
//        case addonID = "addon_id"
//        case addonCategoryID = "addon_category_id"
//        case addonName = "addon_name"
//        case addonSize = "addon_size"
//        case addonPrice = "addon_price"
//        case addonStatus = "addon_status"
//        case merchantDetailsMerchantID = "merchant_details_merchant_id"
//        case uid
//        case addonImage = "addon_image"
//        case sequenceNo = "sequence_no"
//    }
//}

// MARK: - CartScreenResponse
struct CartShowingResponse: Codable {
    let success: Bool
    let message: String
    let parameters: CartShowingParameters
}

// MARK: - Parameters
struct CartShowingParameters: Codable {
    let cart: [Cart]?
    let totalItems: Int
    let fixedTags: FixedTags?
    let outletDetails: OutletDetails
    let outletDeliveryType: [OutletDeliveryType]
    let outletSlot: [OutletSlot]

    enum CodingKeys: String, CodingKey {
        case cart
        case totalItems = "total_items"
        case fixedTags = "fixed_tags"
        case outletDetails = "outlet_details"
        case outletDeliveryType = "outlet_delivery_type"
        case outletSlot = "outlet_slot"
    }
}

// MARK: - Cart
struct Cart: Codable {
    let cartID, customerID: String?
    let deliveryTime: String?
    let amountPayable, amount: String?
    let payMode, deliveryMode, delPerson: String?
    let orderTime: String?
    let voucherID, voucherDiscount: String?
    let merchantDetailsMerchantID, uid, status: String
    let address, radius, alreadyRec, recieveNow: String?
    let customerName, customerAddress, customerMobile, addressTitle: String?
    let addonCost, superCoin, superCoinAmount, delAmt: String?
    let delType, delSlot, cakeCutTime, specialInstruction: String?
    let birthday: String?
    let deliveryDiscount, deliveryCharge: StringValue?
    let cartHasDishDetails: [CartHasDishDetail]
    let cartHasDishaddon: [Addon]
    let canVoucherApply, canCoinApply, isVoucherApplied, isCoinApplied: Int
    let isCoinSelect: Int
    let expectedDeliveryDate: String?
    let totalAmount: String?

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
        case birthday, cartHasDishDetails, cartHasDishaddon
        case deliveryDiscount = "delivery_discount"
        case deliveryCharge = "delivery_charge"
        case canVoucherApply = "can_voucher_apply"
        case canCoinApply = "can_coin_apply"
        case isVoucherApplied = "is_voucher_applied"
        case isCoinApplied = "is_coin_applied"
        case isCoinSelect = "is_coin_select"
        case expectedDeliveryDate = "expected_delivery_date"
        case totalAmount = "total_amount"
    }
}

// MARK: - CartHasDishDetail
struct CartHasDishDetail: Codable {
    let cartHasDishID, cartCartID, dishDetailsDishID: String?
    let quantity: String?
    let orderAmount, created, updated, size: String?
    let cartDishAmount: String
    let voucherDiscount: String?
    let dishID, dishDetailsID, dishName: String?
    let dishImage: String?
    let cuisineID, timeAll, categoryID, dishType: String?
    let unitID: String?
    let customSize, sizeID, serves: String?
    let status, dishPrice, dishDiscounts, dishCreated: String?
    let dishUpdated, dishAvailability, merchantDetailsMerchantID, uid: String?
    let description, discountPercentage, dishOnorder, deliveryTime: String?
    let deliveryMin, deliveryHours, descriptionShow, billingid: String?
    let dishSelection: String?
    let additionalImage, additionalImage2: String?
    let withBackground: String?
    let descriptiveImage: String?
    let customerApplicableClass, cookingTime, avalPickup, dishRating: String?
    let isCustomized, isSlotRestriction, landingPrice, priceDetails: String?
    let category: CartCategory
    let addon: [Addon]?

    enum CodingKeys: String, CodingKey {
        case cartHasDishID = "Cart_has_dish_id"
        case cartCartID = "Cart_cart_id"
        case dishDetailsDishID = "dish_details_dish_id"
        case quantity
        case orderAmount = "order_amount"
        case created, updated, size
        case cartDishAmount = "cart_dish_amount"
        case voucherDiscount = "voucher_discount"
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
        case cookingTime = "cooking_time"
        case avalPickup = "aval_pickup"
        case dishRating = "dish_rating"
        case isCustomized = "is_customized"
        case isSlotRestriction = "is_slot_restriction"
        case landingPrice = "landing_price"
        case priceDetails = "price_details"
        case category, addon
    }
}

// MARK: - Addon
struct Addon: Codable {
    let cartDishHasAddonID, cartID, dishID, addonID: String?
    let merchantID, uid: String?
    let addonCart: AddonCart?

    enum CodingKeys: String, CodingKey {
        case cartDishHasAddonID = "cart_dish_has_addon_id"
        case cartID = "cart_id"
        case dishID = "dish_id"
        case addonID = "addon_id"
        case merchantID = "merchant_id"
        case uid
        case addonCart = "addon_cart"
    }
}

// MARK: - AddonCart
struct AddonCart: Codable {
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

// MARK: - Category
struct CartCategory: Codable {
    let categoryID, categoryName: String?
    let categoryImage: String?
    let categoryStatus, categoryCreated, categoryUpdated, merchantDetailsMerchantID: String?
    let uid, categorySequenceNo: String?

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

// MARK: - FixedTags
struct FixedTags: Codable {
    let fixedTag, msg: String?

    enum CodingKeys: String, CodingKey {
        case fixedTag = "fixed_tag"
        case msg
    }
}

// MARK: - OutletDeliveryType
struct OutletDeliveryType: Codable {
    let deliveryID, outletDetailsID, deliverytype, addedDate: String?

    enum CodingKeys: String, CodingKey {
        case deliveryID = "delivery_id"
        case outletDetailsID = "outlet_details_id"
        case deliverytype
        case addedDate = "added_date"
    }
}

// MARK: - OutletDetails
struct OutletDetails: Codable {
    let outletID, merchantID, outletName, email: String?
    let logo: String?
    let slogan, longitude, latitude, address: String?
    let city, state, mobile, phone: String?
    let cpName: String?
    let cpPhone: String?
    let cpMobile, cpEmail, deliveryRadius: String?
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
struct OutletSlot: Codable {
    let deliverySlotID, deliverySlotName, outletID, uid: String?
    let addedDate, from, to: String?
    let isDisabled: Int

    enum CodingKeys: String, CodingKey {
        case deliverySlotID = "delivery_slot_id"
        case deliverySlotName = "delivery_slot_name"
        case outletID = "outlet_id"
        case uid
        case addedDate = "added_date"
        case from, to
        case isDisabled = "is_disabled"
    }
}

enum StringValue: Codable {
    
    case string(String)
    
    var stringValue: String? {
        switch self {
        case .string(let s):
            return s
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .string("\(x)")
            return
        }
        throw DecodingError.typeMismatch(MyValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for MyValue"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        }
    }
}
