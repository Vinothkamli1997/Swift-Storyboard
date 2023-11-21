//
//  PaymentOptionResponse.swift
//  EliteCake
//
//  Created by TechnoTackle on 16/08/23.
//

import Foundation


struct PaymentOptionResponse: Codable {
    let success: Bool
    let message: String
    let parameters: PaymentOptionParameters
}

// MARK: - Parameters
struct PaymentOptionParameters: Codable {
    let cart: [Cartt]
    let availablePaymentModes: [String]?

    enum CodingKeys: String, CodingKey {
        case cart
        case availablePaymentModes = "available_payment_modes"
    }
}

// MARK: - Cart
struct Cartt: Codable {
    let cartID, customerID: String?
    let deliveryTime: String?
    let amountPayable, amount: String?
    let payMode, deliveryMode, delPerson: String?
    let orderTime: String?
    let voucherID, voucherDiscount: String?
    let merchantDetailsMerchantID, uid, status: String?
    let address, radius, alreadyRec, recieveNow: String?
    let customerName, customerAddress, customerMobile, addressTitle: String?
    let addonCost, superCoin, superCoinAmount, delAmt: String?
    let delType, delSlot, cakeCutTime, specialInstruction: String?
    let birthday, deliveryDiscount, deliveryCharge: String?
    let cartHasDishDetails: [CartHasDishdetail]

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
        case deliveryDiscount = "delivery_discount"
        case deliveryCharge = "delivery_charge"
        case cartHasDishDetails
    }
}

// MARK: - CartHasDishDetail
struct CartHasDishdetail: Codable {
    let cartHasDishID, cartCartID, dishDetailsDishID, quantity: String?
    let orderAmount, created, updated, size: String?
    let cartDishAmount: String?
    let voucherDiscount: String?
    let dishDetailsDish: DishDetailsDish?

    enum CodingKeys: String, CodingKey {
        case cartHasDishID = "Cart_has_dish_id"
        case cartCartID = "Cart_cart_id"
        case dishDetailsDishID = "dish_details_dish_id"
        case quantity
        case orderAmount = "order_amount"
        case created, updated, size
        case cartDishAmount = "cart_dish_amount"
        case voucherDiscount = "voucher_discount"
        case dishDetailsDish
    }
}

// MARK: - DishDetailsDish
struct DishDetailsDish: Codable {
    let dishID, dishDetailsID, dishName, dishImage: String?
    let cuisineID, timeAll, categoryID, dishType: String?
    let unitID: String?
    let customSize, sizeID, serves: String?
    let status, dishPrice, dishDiscounts, dishCreated: String?
    let dishUpdated, dishAvailability, merchantDetailsMerchantID, uid: String?
    let description, discountPercentage, dishOnorder, deliveryTime: String?
    let deliveryMin, deliveryHours, descriptionShow, billingid: String?
    let dishSelection, additionalImage, additionalImage2, withBackground: String?
    let descriptiveImage, customerApplicableClass, cookingTime, avalPickup: String?
    let dishRating, isCustomized, isSlotRestriction, landingPrice: String?
    let priceDetails: String?
    
    enum CodingKeys: String, CodingKey {
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
    }
}
