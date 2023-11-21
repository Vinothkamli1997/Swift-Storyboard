//
//  ShowAllFlavourResponse.swift
//  EliteCake
//
//  Created by TechnoTackle on 02/08/23.
//

import Foundation


// MARK: - ShowAllFlavourResponse
struct ShowAllFlavourResponse: Codable {
    let success: Bool
    let message: String
    let parameters: ShowAllFlavourParameters
}

// MARK: - Parameters
struct ShowAllFlavourParameters: Codable {
    let dish: [ShowAllFlavourDish]
    let page: Pagess
}

// MARK: - Dish
struct ShowAllFlavourDish: Codable {
    let dishID, dishDetailsID, dishName: String
    let dishImage: String
    let cuisineID, timeAll, categoryID: String
    let dishType: String
    let unitID: String
    let customSize, sizeID, serves: String?
    let status: String?
    let dishPrice, dishDiscounts, dishCreated, dishUpdated: String
    let dishAvailability: String
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
    let dishsizes: [ShowAllDishsize]
    let addonDetailsCat: [ShowAllAddonDetailsCat]
    let category: ShowAllCategory

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
    }
}

// MARK: - AddonDetailsCat
struct ShowAllAddonDetailsCat: Codable {
    let addonCategoryID: String
    let addonCategoryName: AddonCategoryName
    let addonCategorySequenceNo: String
    let multipleSelection: IsCustomized
    let addonCategoryStatus: Status
    let merchantDetailsMerchantID, uid: String
    let addonDetailsCatAdddon: [ShowAllAddonDetailsCatAdddon]?

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

enum AddonCategoryName: String, Codable {
    case changeFlavour = "Change Flavour"
}

enum Status: String, Codable {
    case active = "Active"
}

// MARK: - AddonDetailsCatAdddon
struct ShowAllAddonDetailsCatAdddon: Codable {
    let addonID, addonCategoryID, addonName, addonSize: String?
    let addonPrice: String
    let addonStatus: Status
    let merchantDetailsMerchantID, uid: String
    let addonImage: AddonImage
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

enum AddonImage: String, Codable {
    case imagesUploadsAddon2StrPNG = "/images/uploads/addon/2str.png"
    case imagesUploadsAddonImage225275ChipJpg = "/images/uploads/addon_image/225275chip.jpg"
    case imagesUploadsAddonImage307973DfJpg = "/images/uploads/addon_image/307973df.jpg"
    case imagesUploadsAddonImage319243ChipJpg = "/images/uploads/addon_image/319243chip.jpg"
    case imagesUploadsAddonImage356178DfJpg = "/images/uploads/addon_image/356178df.jpg"
    case imagesUploadsAddonImage376775MangoPNGDownloadImagePNG = "/images/uploads/addon_image/376775Mango-PNG-Download-Image.png"
    case imagesUploadsAddonImage391539DfJpg = "/images/uploads/addon_image/391539df.jpg"
    case imagesUploadsAddonImage406333ChipJpg = "/images/uploads/addon_image/406333chip.jpg"
    case imagesUploadsAddonImage49797DfJpg = "/images/uploads/addon_image/49797df.jpg"
    case imagesUploadsAddonImage502284ChipJpg = "/images/uploads/addon_image/502284chip.jpg"
    case imagesUploadsAddonImage567798ChipJpg = "/images/uploads/addon_image/567798chip.jpg"
    case imagesUploadsAddonImage652715DfJpg = "/images/uploads/addon_image/652715df.jpg"
    case imagesUploadsAddonImage734735ChipJpg = "/images/uploads/addon_image/734735chip.jpg"
    case imagesUploadsAddonImage746127DfJpg = "/images/uploads/addon_image/746127df.jpg"
    case imagesUploadsAddonImage755324MangoPNGDownloadImagePNG = "/images/uploads/addon_image/755324Mango-PNG-Download-Image.png"
    case imagesUploadsAddonImage758380MangoPNGDownloadImagePNG = "/images/uploads/addon_image/758380Mango-PNG-Download-Image.png"
    case imagesUploadsAddonImage807894MangoPNGDownloadImagePNG = "/images/uploads/addon_image/807894Mango-PNG-Download-Image.png"
    case imagesUploadsAddonImage865659ChipJpg = "/images/uploads/addon_image/865659chip.jpg"
    case imagesUploadsAddonImage876719MangoPNGDownloadImagePNG = "/images/uploads/addon_image/876719Mango-PNG-Download-Image.png"
    case imagesUploadsAddonImage943574MangoPNGDownloadImagePNG = "/images/uploads/addon_image/943574Mango-PNG-Download-Image.png"
    case imagesUploadsAddonImage976974MangoPNGDownloadImagePNG = "/images/uploads/addon_image/976974Mango-PNG-Download-Image.png"
    case imagesUploadsAddonImage997634DfJpg = "/images/uploads/addon_image/997634df.jpg"
    case imagesUploadsAddonMixFPNG = "/images/uploads/addon/mix f.png"
    case imagesUploadsAddonOrangePNG = "/images/uploads/addon/orange.png"
}

enum IsCustomized: String, Codable {
    case no = "No"
    case yes = "Yes"
}

// MARK: - Category
struct ShowAllCategory: Codable {
    let categoryID, categoryName: String
    let categoryImage: String
    let categoryStatus: Status
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

enum CustomerApplicableClass: String, Codable {
    case customerApplicable = "customer_applicable"
}

enum DeliveryHours: String, Codable {
    case empty = ""
    case the01 = "01"
}

enum DescriptionShow: String, Codable {
    case yes = "yes"
}

enum DishAvailability: String, Codable {
    case available = "Available"
}

enum DishSelection: String, Codable {
    case menu = "menu"
}

enum DishType: String, Codable {
    case veg = "veg"
}

// MARK: - Dishsize
struct ShowAllDishsize: Codable {
    let ddhsdID, dishDetailsDishID, sizeDetailsSizeID, dsDishPrice: String
    let dsServes, dsMrp, dsDisPercentage, landingPrice: String
    let status: Status
    let validFrom: JSONNull?
    let sizeDetailsSize: ShowAllSizeDetailsSize

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
struct ShowAllSizeDetailsSize: Codable {
    let sizeID, sizeName, unitID, merchantDetailsMerchantID: String
    let uid: String
    let unit: ShowAllUnit

    enum CodingKeys: String, CodingKey {
        case sizeID = "size_id"
        case sizeName = "size_name"
        case unitID = "unit_id"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid, unit
    }
}

// MARK: - Unit
struct ShowAllUnit: Codable {
    let unitID: String
    let unitName: UnitName
    let unitStatus: Status
    let unitCreated, unitUpdated: UnitAted
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

enum UnitAted: String, Codable {
    case the20221114144509 = "2022-11-14 14:45:09"
}

enum UnitName: String, Codable {
    case pound = "Pound"
}

// MARK: - Page
struct Pagess: Codable {
    let totalPages, currentPage: Int

    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case currentPage = "current_page"
    }
}
