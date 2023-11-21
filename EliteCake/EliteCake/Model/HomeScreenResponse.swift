//
//  HomeScreenResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 24/01/23.
//

import Foundation
import UIKit


// MARK: - HomeScreenResponse
struct HomeScreenResponse: Codable {
    let success: Bool
    let message: String
    let parameters: HomeScreenParameters
}

// MARK: - Parameters
struct HomeScreenParameters: Codable {
    let outletID, merchantID, outletName, email: String
    let logo: String?
    let slogan, longitude, latitude, address: String
    let city, state, mobile, phone: String
    let cpName: String
    let cpPhone: String?
    let cpMobile, cpEmail, deliveryRadius: String
    let packageID, packageFrom, packageTo, cgst: String?
    let sgst: String?
    let payModeCod, deliveryTime, webLink: String
    let pModeOnline: String?
    let fbLink: String
    let instaLink: String
    let menuID: String?
    let cVoucher, cCustomerClass, cMembership, cWallet: String
    let openAt, closeAt: String
    let status: String
    let masterCopy: String
    let packageStatus: String
    let taxDeductionPrices, dishSelection, dummyPassword, tax: String
    let stateCode, serviceArea, uid: String
    let banner: [Banner]
    let video: [Video]?
    let menu: [JSONAny]
    let vouchers: [Voucher]?
    let cusine: [Cusine]
    let viewFullMenu: [ViewFullMenu]?
    let deliveryType: [DeliveryType]
    let popularofweek: [Popularofweek]?
    let newArrival: [NewArrival]?
    var category: [Category]

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
        case banner
        case menu
        case vouchers
        case cusine
        case video
        case viewFullMenu = "view_full_menu"
        case deliveryType = "delivery_type"
        case popularofweek
        case newArrival = "new_arrival"
        case category
    }
}

// MARK: - Banner
struct Banner: Codable {
    let bannerDetailsID: String
    let bannerName, bannerDescriptions: String?
    let bannerTitle: String
    let images: String
    let status: String
    let bannerFromDate, bannerToDate: String
    let merchantDetailsMerchantID: String
    let uid: String

    enum CodingKeys: String, CodingKey {
        case bannerDetailsID = "banner_details_id"
        case bannerName = "banner_name"
        case bannerDescriptions = "banner_descriptions"
        case bannerTitle = "banner_title"
        case images, status
        case bannerFromDate = "banner_from_date"
        case bannerToDate = "banner_to_date"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
    }
}


// MARK: - Category
struct Category: Codable {
    let categoryID, categoryName: String
    let categoryImage: String
    let categoryStatus: String?
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

// MARK: - Cusine
struct Cusine: Codable {
    let cuisineID, cuisineName: String
    let cuisineStatus: String?
    let cuisineImage: String
    let merchantDetailsMerchantID: String?
    let uid: String?
    let cusineSequenceNo: String?

    enum CodingKeys: String, CodingKey {
        case cuisineID = "cuisine_id"
        case cuisineName = "cuisine_name"
        case cuisineStatus = "cuisine_status"
        case cuisineImage = "cuisine_image"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
        case cusineSequenceNo = "cusine_sequence_no"
    }
}

// MARK: - DeliveryType
struct DeliveryType: Codable {
    let deliveryID, outletDetailsID, deliverytype, addedDate: String

    enum CodingKeys: String, CodingKey {
        case deliveryID = "delivery_id"
        case outletDetailsID = "outlet_details_id"
        case deliverytype
        case addedDate = "added_date"
    }
}

// MARK: - NewArrival
struct NewArrival: Codable {
    let ddhsdlID, dishDetailsDishID, dishShowcaseListDishShowcaseListID, status: String
    let dishShowcaseFrom, dishShowcaseTo, merchantDetailsMerchantID, uid: String
    let dishes: Dishes
    let addonAvailable: Bool

    enum CodingKeys: String, CodingKey {
        case ddhsdlID = "ddhsdl_id"
        case dishDetailsDishID = "dish_details_dish_id"
        case dishShowcaseListDishShowcaseListID = "dish_showcase_list_dish_showcase_list_id"
        case status
        case dishShowcaseFrom = "dish_showcase_from"
        case dishShowcaseTo = "dish_showcase_to"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid, dishes
        case addonAvailable = "addon_available"
    }
}

// MARK: - Dishes
struct Dishes: Codable {
    let dishID, dishDetailsID, dishName: String
    let dishImage: String
    let cuisineID, timeAll, categoryID: String
    let dishType: String?
    let unitID: String
    let customSize, sizeID, serves: String?
    let status: String
    let dishPrice, dishDiscounts, dishCreated, dishUpdated: String
    let dishAvailability, merchantDetailsMerchantID, uid, description: String
    let discountPercentage, dishOnorder, deliveryTime, deliveryMin: String
    let deliveryHours, descriptionShow, billingid, dishSelection: String
    let additionalImage, additionalImage2: String
    let withBackground: String
    let descriptiveImage: String
    let customerApplicableClass, cookingTime, avalPickup, dishRating: String
    let isCustomized, isSlotRestriction, landingPrice, priceDetails: String
    let dishsizes: [Dishsize]
    let addonDetailsCat: [AddonDetailsCat]?
    let category: Category
    let message: String?

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
        case category, message
    }
}

// MARK: - AddonDetailsCat
struct AddonDetailsCat: Codable {
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

// MARK: - AddonDetailsCatAdddon
struct AddonDetailsCatAdddon: Codable {
    let addonID, addonCategoryID: String
    let addonName: String
    let addonSize, addonPrice: String?
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

enum AddonName: String, Codable {
    case butterScotch = "Butter Scotch"
    case chocolate = "Chocolate "
    case mango = "Mango"
    case mixedFruitCocktail = "Mixed Fruit Cocktail"
    case orange = "Orange"
    case strawberry = "Strawberry"
}

// MARK: - Dishsize
struct Dishsize: Codable {
    let ddhsdID, dishDetailsDishID, sizeDetailsSizeID, dsDishPrice: String
    let dsServes, dsMrp, dsDisPercentage, landingPrice: String
    let status: String
    let validFrom: String?
    let sizeDetailsSize: SizeDetailsSize

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
struct SizeDetailsSize: Codable {
    let sizeID, sizeName, unitID, merchantDetailsMerchantID: String
    let uid: String
    let unit: Unit?

    enum CodingKeys: String, CodingKey {
        case sizeID = "size_id"
        case sizeName = "size_name"
        case unitID = "unit_id"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid = "uid"
        case unit = "unit"
        
    }
}

// MARK: - Unit
struct Unit: Codable {
    let unitID: String
    let unitName: String
    let unitStatus: String
    let unitCreated: String
    let unitUpdated: String
    let merchantDetailsMerchantID: String
    let uid: String

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

// MARK: - Popularofweek
struct Popularofweek: Codable {
    let ddhsdlID, dishDetailsDishID, dishShowcaseListDishShowcaseListID, status: String
    let dishShowcaseFrom, dishShowcaseTo, merchantDetailsMerchantID, uid: String
    let dishes: Dishes

    enum CodingKeys: String, CodingKey {
        case ddhsdlID = "ddhsdl_id"
        case dishDetailsDishID = "dish_details_dish_id"
        case dishShowcaseListDishShowcaseListID = "dish_showcase_list_dish_showcase_list_id"
        case status
        case dishShowcaseFrom = "dish_showcase_from"
        case dishShowcaseTo = "dish_showcase_to"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid, dishes
    }
}

// MARK: - Video
struct Video: Codable {
    let id, sizeID, dishID, dishName: String
    let title, fromDate, toDate: String
    let thumbnailImage: String
    let video: String

    enum CodingKeys: String, CodingKey {
        case id
        case sizeID = "size_id"
        case dishID = "dish_id"
        case dishName = "dish_name"
        case title
        case fromDate = "from_date"
        case toDate = "to_date"
        case thumbnailImage = "thumbnail_image"
        case video
    }
}

// MARK: - ViewFullMenu
struct ViewFullMenu: Codable {
    let viewFullMenuID: String
    let bannerName, bannerDescriptions: String?
    let menuTitle: String
    let images: String
    let status: String
    let menuFromDate, menuToDate, merchantDetailsMerchantID, uid: String

    enum CodingKeys: String, CodingKey {
        case viewFullMenuID = "view_full_menu_id"
        case bannerName = "banner_name"
        case bannerDescriptions = "banner_descriptions"
        case menuTitle = "menu_title"
        case images, status
        case menuFromDate = "menu_from_date"
        case menuToDate = "menu_to_date"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
    }
}

// MARK: - Voucher
struct Voucher: Codable {
    let vouchersID, merchantDetailsMerchantID, uid, vouchersName: String
    let vouchersMinOrderValue, vouchersOff, vouchersCode, vouchersCashbackCoins: String?
    let maxAmount: String?
    let maxUsage, intervals: String
    let instant: String?
    let cod, onlinePayment: String?
    let customerApplicable, publishDate: String
    let publishTime, validUpto, notification, sheduleTime: String
    let sheduleDate: String
    let status: String
    let publishInstant, used, maxAmountForCashback, maxAmountForInstant: String
    let descriptionShow: String?
    let description, customerApplicableClass, instantPercent: String

    enum CodingKeys: String, CodingKey {
        case vouchersID = "vouchers_id"
        case merchantDetailsMerchantID = "merchant_details_merchant_id"
        case uid
        case vouchersName = "vouchers_name"
        case vouchersMinOrderValue = "vouchers_min_order_value"
        case vouchersOff = "vouchers_off"
        case vouchersCode = "vouchers_code"
        case vouchersCashbackCoins = "vouchers_cashback_coins"
        case maxAmount = "max_amount"
        case maxUsage = "max_usage"
        case intervals, instant, cod
        case onlinePayment = "online_payment"
        case customerApplicable = "customer_applicable"
        case publishDate = "publish_date"
        case publishTime = "publish_time"
        case validUpto = "valid_upto"
        case notification
        case sheduleTime = "shedule_time"
        case sheduleDate = "shedule_date"
        case status
        case publishInstant = "publish_instant"
        case used
        case maxAmountForCashback = "max_amount_for_cashback"
        case maxAmountForInstant = "max_amount_for_instant"
        case descriptionShow = "description_show"
        case description
        case customerApplicableClass = "customer_applicable_class"
        case instantPercent = "instant_percent"
    }
}

// MARK: - Encode/decode helpers


class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
