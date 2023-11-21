//
//  MyFavouriteReponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 24/03/23.
//

import Foundation


// MARK: - MyFavouriteResponse
struct MyFavouriteResponse: Codable {
    let success: Bool
    let message: String
    let parameters: MyFavouriteParameters
}

// MARK: - Parameters
struct MyFavouriteParameters: Codable {
    let dish: [MyFavouriteDish]
}

// MARK: - Dish
struct MyFavouriteDish: Codable {
    let dishID, dishDetailsID, dishName, dishImage: String
    let cuisineID, timeAll, categoryID: String
    let dishType: String?
    let unitID: String
    let customSize, sizeID, serves: JSONNull?
    let status: String
    let dishPrice, dishDiscounts: String?
    let dishCreated: String
    let dishUpdated, dishAvailability, merchantDetailsMerchantID, uid: String
    let description, discountPercentage, dishOnorder, deliveryTime: String
    let deliveryMin, deliveryHours, descriptionShow, billingid: String
    let dishSelection: String
    let additionalImage, additionalImage2, withBackground, descriptiveImage: String?
    let customerApplicableClass, cookingTime, avalPickup: String
    let dishRating, isCustomized, isSlotRestriction, landingPrice: String
    let priceDetails: String
    let category: Category

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
        case category
    }
}
