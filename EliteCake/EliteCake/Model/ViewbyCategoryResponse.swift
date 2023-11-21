//
//  ViewbyCategoryResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 27/02/23.
//

import Foundation

// MARK: - ViewbyCategoryResponse
struct ViewbyCategoryResponse: Codable {
    let success: Bool
    let message: String
    let parameters: ViewbyCategoryParameters?
}

// MARK: - Parameters
struct ViewbyCategoryParameters: Codable {
    let page: Page
    let dish: [CategoryDish]
}

// MARK: - Dish
struct CategoryDish: Codable {
    let dishID, dishDetailsID, dishName: String
    let dishImage: String
    let cuisineID, timeAll, categoryID: String
    let dishType: String?
    let unitID: String
    let customSize: JSONNull?
    let sizeID: String?
    let serves: JSONNull?
    let status: String
    let dishPrice, dishDiscounts: String?
    let dishCreated, dishUpdated: String
    var dishAvailability: String
    let merchantDetailsMerchantID, uid, description, discountPercentage: String
    let dishOnorder, deliveryTime, deliveryMin: String
    let deliveryHours: String
    let descriptionShow: String
    let billingid: String
    let dishSelection: String
    let additionalImage, additionalImage2: String
    let withBackground: String
    let descriptiveImage: String
    let customerApplicableClass: String
    let cookingTime, avalPickup, dishRating: String
    let isCustomized: String
    let isSlotRestriction, landingPrice, priceDetails: String
    let dishsizes: [Dishsize]
    let addonDetailsCat: [AddonDetailsCat]
    let category: Category
    var foodFavorite: Bool
    let availability: String
    let cartHasDishDetails: [CartHasDishDetails]
    let addonAvailable: Bool
    let tag: String

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
        case dishsizes
        case addonDetailsCat = "addonDetails_cat"
        case category
        case foodFavorite = "food_favorite"
        case availability, cartHasDishDetails
        case addonAvailable = "addon_available"
        case tag
    }
}

// MARK: - Page
struct Page: Codable {
    let totalPages, currentPage: Int

    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case currentPage = "current_page"
    }
}

// MARK: - CartHasDishDetail
struct CartHasDishDetails: Codable {
    let cartHasDishID, cartCartID, dishDetailsDishID, quantity: String
    let orderAmount, created, updated, size: String
    let cartDishAmount: String
    let voucherDiscount: String?

    enum CodingKeys: String, CodingKey {
        case cartHasDishID = "Cart_has_dish_id"
        case cartCartID = "Cart_cart_id"
        case dishDetailsDishID = "dish_details_dish_id"
        case quantity
        case orderAmount = "order_amount"
        case created, updated, size
        case cartDishAmount = "cart_dish_amount"
        case voucherDiscount = "voucher_discount"
    }
}
