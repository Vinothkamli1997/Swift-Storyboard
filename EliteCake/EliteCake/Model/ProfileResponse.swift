//
//  ProfileResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 25/05/23.
//

import Foundation

// MARK: - ProfileResponse
struct ProfileResponse: Codable {
    let success: Bool
    let message: String
    let parameters: ProfileParameters
}

// MARK: - Parameters
struct ProfileParameters: Codable {
    let customerDetailsID, customerName: String?
    let customerMobile: String?
    let username: String?
    let loginWith: String?
    let dateOfActivation: String?
    let merchantDetailsMerchantID, uid: String?
    let membershipID: String?
    let status, created, updated: String?
    let password, membership: String?
    let action, customerAddress: String?
    let customerEmail: String?
    let socialID, response: String?
    let otp, customeImage, dateOfBirth, referalCode: String?
    let usedReferalCode, isProfileCompleted, isReferalCoinAdded, lastLoginTime: String?

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
    }
}
