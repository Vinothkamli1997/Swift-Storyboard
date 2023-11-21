//
//  akeAddonResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 18/02/23.
//

import Foundation
import UIKit

// MARK: - CakeAddonResponse
//struct CakeAddonResponse: Codable {
//    let success: Bool
//    let message: String
//    let parameters: CakeAddonParameters
//}
//
//// MARK: - Parameters
//struct CakeAddonParameters: Codable {
//    let dish: AddonDish
//    let dishCartDetails: [JSONAny]
//
//    enum CodingKeys: String, CodingKey {
//        case dish
//        case dishCartDetails = "dish cart details"
//    }
//}
//
//// MARK: - Dish
//struct AddonDish: Codable {
//    let dishID, dishDetailsID, dishName: String
//    let dishImage: String
//    let cuisineID, timeAll, categoryID, dishType: String
//    let unitID: String
//    let customSize, sizeID, serves: String?
//    let status: String
//    let dishPrice, dishDiscounts, dishCreated, dishUpdated: String
//    let dishAvailability, merchantDetailsMerchantID, uid, description: String
//    let discountPercentage, dishOnorder, deliveryTime, deliveryMin: String
//    let deliveryHours, descriptionShow, billingid, dishSelection: String
//    let additionalImage, additionalImage2, withBackground, descriptiveImage: String?
//    let customerApplicableClass, dishCookingTime, avalPickup, dishRating: String?
//    let isCustomized, isSlotRestriction, landingPrice, priceDetails: String
//    let unit: Unit
//    let addonDetailsCat: [AddonDetailsCat]?
//    let dishsizes: [Dishsize]
//    let availability, cookingTime, takeAway: String?
//    var foodFavorite: Bool?
//    let suggested: [AddonDish]?
//    let category: Category?
//
//    enum CodingKeys: String, CodingKey {
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
//        case dishCookingTime = "cooking_time"
//        case avalPickup = "aval_pickup"
//        case dishRating = "dish_rating"
//        case isCustomized = "is_customized"
//        case isSlotRestriction = "is_slot_restriction"
//        case landingPrice = "landing_price"
//        case priceDetails = "price_details"
//        case unit
//        case addonDetailsCat = "addonDetails_cat"
//        case dishsizes
//        case availability = "Availability"
//        case cookingTime = "Cooking Time"
//        case takeAway = "take_away"
//        case foodFavorite = "food_favorite"
//        case suggested, category
//    }
//}

// MARK: - CakeAddonResponse
struct CakeAddonResponse: Codable {
    let success: Bool
    let message: String
    let parameters: CakeAddonParameters
}

// MARK: - Parameters
struct CakeAddonParameters: Codable {
    let dish: AddonDish
    let dishCartDetails: [DishCartDetail]

    enum CodingKeys: String, CodingKey {
        case dish
        case dishCartDetails = "dish cart details"
    }
}

// MARK: - Dish
struct AddonDish: Codable {
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
    let additionalImage, additionalImage2, withBackground: String
    let descriptiveImage: String
    let customerApplicableClass, cookingTime, avalPickup, dishRating: String
    let isCustomized, isSlotRestriction, landingPrice, priceDetails: String
    let unit: Unit
    let addonDetailsCat: [DishAddonDetailsCat]?
    let dishsizes: [AddonDishsize]
    let availability, takeAway, days: String?
    var foodFavorite: Bool
    let dishaddons: [DishCartDetail]?
    let suggested: [Suggested]?

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
        case dishsizes
        case availability = "Availability"
        case days
        case takeAway = "take_away"
        case foodFavorite = "food_favorite"
        case dishaddons, suggested
//        case suggested
    }
}

// MARK: - DishAddonDetailsCat
struct DishAddonDetailsCat: Codable {
    let addonCategoryID, addonCategoryName, addonCategorySequenceNo: String
    var multipleSelection: String
    let addonCategoryStatus: String
    let merchantDetailsMerchantID, uid: String
    let addonDetailsCatAdddon: [AddonDetailsCatAdddon]?

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

// MARK: - PurpleAddonDetailsCatAdddon
struct PurpleAddonDetailsCatAdddon: Codable {
    let addonID, addonCategoryID, addonName: String
    let addonSize: String
    let addonPrice: String
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

// MARK: - Dishsize
struct AddonDishsize: Codable {
    let ddhsdID, dishDetailsDishID, sizeDetailsSizeID, dsDishPrice: String
    let dsServes, dsMrp, dsDisPercentage, landingPrice: String
    let status: String
    let validFrom: String?
    let sizeDetailsSize: AddonSizeDetailsSize

    enum CodingKeys: String, CodingKey {
        case ddhsdID = "ddhsd_id"
        case dishDetailsDishID = "dish_details_dish_id"
        case sizeDetailsSizeID = "size_details_size_id"
        case dsDishPrice = "ds_dish_price"
        case dsServes = "ds_serves"
        case dsMrp = "ds_mrp"
        case dsDisPercentage = "ds_dis_percentage"
        case landingPrice = "landing_price"
        case status
        case validFrom = "valid_from"
        case sizeDetailsSize
    }
}

// MARK: - SizeDetailsSize
struct AddonSizeDetailsSize: Codable {
    let sizeID, sizeName, unitID, merchantDetailsMerchantID: String
    let uid, tagCategoryID, tagID: String?
    let unit: AddonUnit?

    enum CodingKeys: String, CodingKey {
        case sizeID = "size_id"
        case sizeName = "size_name"
        case unitID = "unit_id"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
        case tagCategoryID = "tag_category_id"
        case tagID = "tag_id"
        case unit
    }
}

// MARK: - Unit
struct AddonUnit: Codable {
    let unitID: String
    let unitName: String
    let unitStatus: String
    let unitCreated, unitUpdated: String
    let merchantDetailsMerchantID, uid: String

    enum CodingKeys: String, CodingKey {
        case unitID = "unit_id"
        case unitName = "unit_name"
        case unitStatus = "unit_status"
        case unitCreated = "unit_created"
        case unitUpdated = "unit_updated"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
    }
}

// MARK: - Suggested
struct Suggested: Codable {
    let dishID, dishDetailsID, dishName: String?
    let dishImage: String?
    let cuisineID, timeAll, categoryID, dishType: String?
    let unitID: String?
    let customSize, sizeID, serves: String?
    let status: String?
    let dishPrice, dishDiscounts, dishCreated, dishUpdated: String?
    let dishAvailability, merchantDetailsMerchantID, uid, description: String?
    let discountPercentage, dishOnorder, deliveryTime, deliveryMin: String?
    let deliveryHours, descriptionShow, billingid, dishSelection: String?
    let additionalImage, additionalImage2, withBackground: String?
    let descriptiveImage: String?
    let customerApplicableClass, cookingTime, avalPickup, dishRating: String?
    let isCustomized, isSlotRestriction, landingPrice, priceDetails: String?
    let unit: Unit
    let addonDetailsCat: [SuggestedAddonDetailsCat]?
    let dishsizes: [Dishsize]
    let category: AddonCategory?

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
    }
}

// MARK: - SuggestedAddonDetailsCat
struct SuggestedAddonDetailsCat: Codable {
    let addonCategoryID, addonCategoryName, addonCategorySequenceNo, multipleSelection: String
    let addonCategoryStatus: String
    let merchantDetailsMerchantID, uid: String
    let addonDetailsCatAdddon: [AddonDetailsCatAdddon]?

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

// MARK: - FluffyAddonDetailsCatAdddon
struct FluffyAddonDetailsCatAdddon: Codable {
    let addonID, addonCategoryID: String
    let addonName: String
    let addonSize: MyValue?
        let addonPrice: String?
    let addonStatus: String
    let merchantDetailsMerchantID, uid, addonImage, sequenceNo: String

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
struct AddonCategory: Codable {
    let categoryID, categoryName: String
    let categoryImage: String
    let categoryStatus: String
    let categoryCreated, categoryUpdated, merchantDetailsMerchantID, uid: String
    let categorySequenceNo: String

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

// MARK: - DishCartDetail
struct DishCartDetail: Codable {
    let cartHasDishID, dishDetailsDishID, quantity: String?

    enum CodingKeys: String, CodingKey {
        case cartHasDishID = "Cart_has_dish_id"
        case dishDetailsDishID = "dish_details_dish_id"
        case quantity
    }
}
