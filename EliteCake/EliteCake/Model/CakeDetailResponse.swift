//
//  CakeDetailResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 04/02/23.
//

import Foundation
import UIKit

// MARK: - CakeDetailsResponse
struct CakeDetailsResponse: Codable {
    let success: Bool
    let message: String
    let parameters: CakeDetailParameters
}

// MARK: - Parameters
struct CakeDetailParameters: Codable {
    var dish: Dish
    let dishCartDetails: [CakeDishCartDetail]?

    enum CodingKeys: String, CodingKey {
        case dish
        case dishCartDetails = "dish cart details"
    }
}

// MARK: - Dish
struct Dish: Codable {
    let dishID, dishDetailsID, dishName: String
    let dishImage: String
    let cuisineID, timeAll, categoryID, dishType: String
    let unitID: String
    let customSize, sizeID, serves: String?
    let status: String
    let dishPrice, dishDiscounts, dishCreated, dishUpdated: String
    let dishAvailability, merchantDetailsMerchantID, uid, description: String
    let discountPercentage, dishOnorder, deliveryTime, deliveryMin: String
    let deliveryHours, descriptionShow, billingid, dishSelection: String
    let additionalImage, additionalImage2, withBackground, descriptiveImage: String
    let customerApplicableClass, cookingTime, avalPickup: String
    let dishRating: String?
    let isCustomized, isSlotRestriction, landingPrice, priceDetails: String
    let unit: Unit
    let addonDetailsCat: [CakeDetailsAddonDetailsCat]?
    let dishsizes: [Dishsize]
    let category: Category
    var foodFavorite: Bool? // Declare as a variable
    let vouchers: [Voucher]?
    let suggested: [Dish]?

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
        case unit
        case addonDetailsCat = "addonDetails_cat"
        case dishsizes, category
        case foodFavorite = "food_favorite"
        case vouchers, suggested
    }
}

struct CakeDetailsAddonDetailsCat: Codable {
    let addonCategoryID, addonCategoryName, addonCategorySequenceNo, multipleSelection: String
    let addonCategoryStatus: String
    let merchantDetailsMerchantID, uid: String
    let addonDetailsCatAdddon: [CakeAddonDetailsCatAdddon]?

    enum CodingKeys: String, CodingKey {
        case addonCategoryID = "addon_category_id"
        case addonCategoryName = "addon_category_name"
        case addonCategorySequenceNo = "addon_category_sequence_no"
        case multipleSelection = "multiple_selection"
        case addonCategoryStatus = "addon_category_status"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
        case addonDetailsCatAdddon = "addonDetails_cat_adddon"
    }
}

struct CakeAddonDetailsCatAdddon: Codable {
    let addonID, addonCategoryID: String
    let addonName: String
    let addonSize: String?
    let addonPrice: String?
    let addonStatus: String
    let merchantDetailsMerchantID, uid: String
    let addonImage: String
    let sequenceNo: String

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

// MARK: - DishCartDetail
struct CakeDishCartDetail: Codable {
    let cartHasDishID, dishDetailsDishID, quantity: String?

    enum CodingKeys: String, CodingKey {
        case cartHasDishID = "Cart_has_dish_id"
        case dishDetailsDishID = "dish_details_dish_id"
        case quantity
    }
}

