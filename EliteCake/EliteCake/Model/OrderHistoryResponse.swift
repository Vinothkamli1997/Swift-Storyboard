//
//  OrderHistoryResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 08/05/23.
//

import Foundation

//// MARK: - OrderHistoryResponse
//struct OrderHistoryResponse: Codable {
//    let success: Bool
//    let message: String
//    let parameters: [OrderHistoryParameter]
//}
//
//// MARK: - Parameter
//struct OrderHistoryParameter: Codable {
//    let orderID, id, customerID: String
//    let deliveryTime: String?
//    let amountPayable, amount, payMode, deliveryMode: String
//    let delPerson: String?
//    let orderTime: String
//    let voucherID, voucherDiscount: String?
//    let merchantDetailsMerchantID, uid, status, time: String
//    let date: String
//    let address, radius, alreadyRec, recieveNow: String?
//    let customerMobile: String
//    let addressTitle: String?
//    let customerAddress, customerName: String
//    let houseNo, area, description, latitude: String?
//    let longitude, mobile, transactionID, cookingTime: String?
//    let addonCost: String
//    let reason: String?
//    let superCoin, superCoinAmount, delAmt, delType: String
//    let delSlot, cakeCutTime, specialInstruction, birthday: String
//    let orderHasDishDetails: [OrderHasDishDetail]
//    let orderStatus: [OrderStatus]
//
//
//    enum CodingKeys: String, CodingKey {
//        case orderID = "order_id"
//        case id
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
//        case uid, status, time, date, address, radius
//        case alreadyRec = "already_rec"
//        case recieveNow = "recieve_now"
//        case customerMobile = "customer_mobile"
//        case addressTitle = "address_title"
//        case customerAddress = "customer_address"
//        case customerName = "customer_name"
//        case houseNo = "house_no"
//        case area, description, latitude, longitude, mobile
//        case transactionID = "transaction_id"
//        case cookingTime = "cooking_time"
//        case addonCost = "addon_cost"
//        case reason
//        case superCoin = "super_coin"
//        case superCoinAmount = "super_coin_amount"
//        case delAmt = "del_amt"
//        case delType = "del_type"
//        case delSlot = "del_slot"
//        case cakeCutTime = "cake_cut_time"
//        case specialInstruction = "special_instruction"
//        case birthday, orderHasDishDetails
//        case orderStatus = "order_status"
//    }
//}
//
//// MARK: - OrderHasDishDetail
//struct OrderHasDishDetail: Codable {
//
//    let orderDishID, orderOrderID, dishDetailsDishID, quantity, orderAmount: String?
//    let created, updated, size, orderDishAmount, voucherDiscount: String?
//
//    let cookingTime, statusByKitchen, reason, cookingStartTime, customerRating, dishID, dishDetailsID: String?
//    let dishName, dishImage, cusineID, timeAll, categoryID, dishType, unitID, customSize: String?
//    let sizeID, serves, status, dishPrice, dishDishCounts, dishCreated, dishUpdated, dishAvailability: String?
//    let merchantDetailsMerchantID, uid, description, discountPercentage, dishOnOrder, deliveryTime, deliveryMin: String?
//    let deliveryHours, descriptionShow, billingId, dishSelection, additionalImage, additionalImage2, withBackground: String?
//    let descriptiveImage, customerApplicableClass, avalPickup, dishRating, isCustomized, isSlotRestriction, landingPrice, priceDetails: String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case orderDishID =                  "order_dish_id"
//        case orderOrderID =                "order_order_id"
//        case  dishDetailsDishID =               "dish_details_dish_id"
//        case  quantity =                     "quantity"
//        case  orderAmount =                "order_amount"
//        case   created =                     "created"
//        case  updated =                       "updated"
//        case  size =                        "size"
//        case  orderDishAmount =               "order_dish_amount"
//        case  voucherDiscount =               "voucher_discount"
//        case  cookingTime =                      "cooking_time"
//        case  statusByKitchen      =         "statusbykitchen"
//        case  reason          =              "reason"
//        case  cookingStartTime =              "cooking_start_time"
//        case   customerRating =             "customer_rating"
//        case   dishID =                          "dish_id"
//        case    dishDetailsID =            "dish_details_id"
//        case  dishName =                         "dish_name"
//        case  dishImage =                     "dish_image"
//        case  cusineID      =                "cuisine_id"
//        case  timeAll   =                    "time_all"
//        case  categoryID =                    "category_id"
//        case  dishType =                   "dish_type"
//        case  unitID =                       "unit_id"
//        case   customSize =                      "custom_size"
//        case  sizeID =                       "size_id"
//        case  serves =                        "serves"
//        case  status =                      "status"
//        case   dishPrice =                    "dish_price"
//        case   dishDishCounts =              "dish_discounts"
//        case   dishCreated =                    "dish_created"
//        case   dishUpdated =                    "dish_updated"
//        case   dishAvailability =             "dish_availability"
//        case   merchantDetailsMerchantID =             "merchant_details_merchant_id"
//        case   uid =                            "uid"
//        case   description =                "description"
//        case   discountPercentage =             "discount_percentage"
//        case    dishOnOrder =               "dish_onorder"
//        case   deliveryTime =                 "delivery_time"
//        case    deliveryMin =                "delivery_min"
//        case    deliveryHours =               "delivery_hours"
//        case    descriptionShow =            "description_show"
//        case    billingId =                  "billingid"
//        case    dishSelection =               "dish_selection"
//        case    additionalImage =            "additional_image"
//        case   additionalImage2 =             "additional_image_2"
//        case   withBackground =              "With_background"
//        case    descriptiveImage =            "Descriptive_Image"
//        case    customerApplicableClass =            "customer_applicable_class"
//        case    avalPickup =                     "aval_pickup"
//        case    dishRating =                     "dish_rating"
//        case    isCustomized =                 "is_customized"
//        case     isSlotRestriction =             "is_slot_restriction"
//        case     landingPrice =                  "landing_price"
//        case     priceDetails =                 "price_details"
//    }
//}
//
//// MARK: - OrderStatus
//struct OrderStatus: Codable {
//    let status, msg, ordertime, date: String
//}

// MARK: - OrderHistoryResponse
//struct OrderHistoryResponse: Codable {
//    let success: Bool
//    let message: String
//    let parameters: OrderHistoryParameters
//}
//
//// MARK: - Parameters
//struct OrderHistoryParameters: Codable {
//    let orderHistory: [OrderHistorys]?
//    let outletDetails: OutletDetail
//
//    enum CodingKeys: String, CodingKey {
//        case orderHistory = "order_history"
//        case outletDetails = "outlet_details"
//    }
//}
//
//// MARK: - OrderHistory
//struct OrderHistorys: Codable {
//    let orderID, id, customerID: String?
//    let deliveryTime: String?
//    let amountPayable, amount, payMode, deliveryMode: String?
//    let delPerson: String?
//    let orderTime: String
//    let voucherID: String?
//    let voucherDiscount, merchantDetailsMerchantID, uid, status: String?
//    let time, date: String?
//    let address, radius, alreadyRec, recieveNow: String?
//    let customerMobile: String?
//    let addressTitle: String?
//    let customerAddress, customerName: String?
//    let houseNo, area, description, latitude: String?
//    let longitude, mobile, transactionID, cookingTime: String?
//    let addonCost: String?
//    let reason: String?
//    let superCoin, superCoinAmount, delAmt, delType: String?
//    let delSlot, cakeCutTime, specialInstruction, birthday: String?
//    let customerAddressID, slotDate, isCashCollected, isDriverAmtCollect: String?
//    let deliveryDiscount, deliveryCharge: String?
//    let orderHasDishDetails: [OrderHasDishDetail]
//    let orderStatus: [OrderStatus]
//
//    enum CodingKeys: String, CodingKey {
//        case orderID = "order_id"
//        case id
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
//        case uid, status, time, date, address, radius
//        case alreadyRec = "already_rec"
//        case recieveNow = "recieve_now"
//        case customerMobile = "customer_mobile"
//        case addressTitle = "address_title"
//        case customerAddress = "customer_address"
//        case customerName = "customer_name"
//        case houseNo = "house_no"
//        case area, description, latitude, longitude, mobile
//        case transactionID = "transaction_id"
//        case cookingTime = "cooking_time"
//        case addonCost = "addon_cost"
//        case reason
//        case superCoin = "super_coin"
//        case superCoinAmount = "super_coin_amount"
//        case delAmt = "del_amt"
//        case delType = "del_type"
//        case delSlot = "del_slot"
//        case cakeCutTime = "cake_cut_time"
//        case specialInstruction = "special_instruction"
//        case birthday
//        case customerAddressID = "customer_address_id"
//        case slotDate = "slot_date"
//        case isCashCollected = "is_cash_collected"
//        case isDriverAmtCollect = "is_driver_amt_collect"
//        case deliveryDiscount = "delivery_discount"
//        case deliveryCharge = "delivery_charge"
//        case orderHasDishDetails
//        case orderStatus = "order_status"
//    }
//}
//
//// MARK: - OrderHasDishDetail
//struct OrderHasDishDetail: Codable {
//    let orderDishID, orderOrderID, dishDetailsDishID, quantity: String?
//    let orderAmount, created, updated, size: String?
//    let orderDishAmount: String?
//    let voucherDiscount: String?
//    let cookingTime, statusbykitchen, reason, cookingStartTime: String?
//    let customerRating: String?
//    let dishID, dishDetailsID, dishName, dishImage: String?
//    let cuisineID, timeAll, categoryID, dishType: String?
//    let unitID: String?
//    let customSize, sizeID, serves: String?
//    let status, dishPrice, dishDiscounts, dishCreated: String?
//    let dishUpdated, dishAvailability, merchantDetailsMerchantID, uid: String?
//    let description, discountPercentage, dishOnorder, deliveryTime: String?
//    let deliveryMin, deliveryHours, descriptionShow, billingid: String?
//    let dishSelection, additionalImage, additionalImage2, withBackground: String?
//    let descriptiveImage, customerApplicableClass, avalPickup, dishRating: String?
//    let isCustomized, isSlotRestriction, landingPrice, priceDetails: String?
//    let addon: [TrackAddon]?
//
//    enum CodingKeys: String, CodingKey {
//        case orderDishID = "order_dish_id"
//        case orderOrderID = "order_order_id"
//        case dishDetailsDishID = "dish_details_dish_id"
//        case quantity
//        case orderAmount = "order_amount"
//        case created, updated, size
//        case orderDishAmount = "order_dish_amount"
//        case voucherDiscount = "voucher_discount"
//        case cookingTime = "cooking_time"
//        case statusbykitchen, reason
//        case cookingStartTime = "cooking_start_time"
//        case customerRating = "customer_rating"
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
//        case avalPickup = "aval_pickup"
//        case dishRating = "dish_rating"
//        case isCustomized = "is_customized"
//        case isSlotRestriction = "is_slot_restriction"
//        case landingPrice = "landing_price"
//        case priceDetails = "price_details"
//        case addon
//    }
//}
//
//// MARK: - OrderStatus
//struct OrderStatus: Codable {
//    let status, msg, ordertime, date: String
//}
//
//// MARK: - OutletDetails
//struct OutletDetail: Codable {
//    let outletID, merchantID, outletName, email: String?
//    let logo: String?
//    let slogan, longitude, latitude, address: String?
//    let city, state, mobile, phone: String?
//    let cpName: String?
//    let cpPhone: String?
//    let cpMobile, cpEmail, deliveryRadius: String?
//    let packageID, packageFrom, packageTo, cgst: String?
//    let sgst: String?
//    let payModeCod, pModeOnline, deliveryTime, webLink: String?
//    let fbLink: String?
//    let instaLink: String?
//    let menuID: String?
//    let cVoucher, cCustomerClass, cMembership, cWallet: String?
//    let openAt, closeAt, status, masterCopy: String?
//    let packageStatus, taxDeductionPrices, dishSelection, dummyPassword: String?
//    let tax, stateCode, serviceArea, uid: String?
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

// MARK: - OrderHistoryResponse
struct OrderHistoryResponse: Codable {
    let success: Bool
    let message: String
    let parameters: OrderHistoryParameters
}

// MARK: - Parameters
struct OrderHistoryParameters: Codable {
    let orderHistory: [OrderHistorys]?
    let outletDetails: OutletDetail

    enum CodingKeys: String, CodingKey {
        case orderHistory = "order_history"
        case outletDetails = "outlet_details"
    }
}

// MARK: - OrderHistory
struct OrderHistorys: Codable {
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
    let customerAddress, customerName, houseNo, area: String?
    let description: String?
    let latitude, longitude, mobile: String?
    let transactionID, cookingTime: String?
    let addonCost: String?
    let reason: String?
    let superCoin, superCoinAmount, delAmt, delType: String?
    let delSlot, cakeCutTime, specialInstruction, birthday: String?
    let customerAddressID, slotDate, isCashCollected, isDriverAmtCollect: String?
    let deliveryDiscount, deliveryCharge: String?
    let orderHasDishDetails: [OrderHasDishDetail]
    let orderStatus: [OrderStatus]

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
        case slotDate = "slot_date"
        case isCashCollected = "is_cash_collected"
        case isDriverAmtCollect = "is_driver_amt_collect"
        case deliveryDiscount = "delivery_discount"
        case deliveryCharge = "delivery_charge"
        case orderHasDishDetails
        case orderStatus = "order_status"
    }
}

// MARK: - OrderHasDishDetail
struct OrderHasDishDetail: Codable {
    let orderDishID, orderOrderID, dishDetailsDishID, quantity: String?
    let orderAmount, created, updated, size: String?
    let orderDishAmount: String?
    let voucherDiscount: String?
    let cookingTime, statusbykitchen, reason, cookingStartTime: String?
    let customerRating: CustomerRating?
    let dishID, dishDetailsID, dishName, dishImage: String?
    let cuisineID, timeAll, categoryID, dishType: String?
    let unitID: String
    let customSize, sizeID, serves: String?
    let status, dishPrice, dishDiscounts, dishCreated: String?
    let dishUpdated, dishAvailability, merchantDetailsMerchantID, uid: String?
    let description, discountPercentage, dishOnorder, deliveryTime: String?
    let deliveryMin, deliveryHours, descriptionShow, billingid: String?
    let dishSelection, additionalImage, additionalImage2, withBackground: String?
    let descriptiveImage, customerApplicableClass, avalPickup, dishRating: String?
    let isCustomized, isSlotRestriction, landingPrice, priceDetails: String?
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
        case customerRating = "customer_rating"
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
        case addon
    }
}

// MARK: - CustomerRating
struct CustomerRating: Codable {
    let reviewID, customerID, orderID, dishID: String?
    let outletID, merchantID, rating, review: String?
    let createdAt, status, uid: String?

    enum CodingKeys: String, CodingKey {
        case reviewID = "review_id"
        case customerID = "customer_id"
        case orderID = "order_id"
        case dishID = "dish_id"
        case outletID = "outlet_id"
        case merchantID = "merchant_id"
        case rating, review
        case createdAt = "created_at"
        case status, uid
    }
}

// MARK: - OrderStatus
struct OrderStatus: Codable {
    let status, msg, ordertime, date: String?
}

// MARK: - OutletDetails
struct OutletDetail: Codable {
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
