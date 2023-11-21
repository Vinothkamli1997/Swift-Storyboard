//
//  DownlineResponse.swift
//  EliteCake
//
//  Created by TechnoTackle on 31/07/23.
//

import Foundation


// MARK: - DownLineResponse
struct DownLineResponse: Codable {
    let success: Bool
    let message: String
    let parameters: [DowlineParameter]?
}

// MARK: - Parameter
struct DowlineParameter: Codable {
    let customerDetailsID, customerName, customerMobile, username: String?
    let loginWith: String?
    let dateOfActivation: String?
    let merchantDetailsMerchantID, uid: String?
    let membershipID: String?
    let status, created, updated, password: String?
    let membership: String?
    let action, customerAddress, customerEmail, socialID: String?
    let response, otp: String?
    let customeImage: String?
    let dateOfBirth, referalCode, usedReferalCode, isProfileCompleted: String?
    let isReferalCoinAdded, lastLoginTime, isForceLogOut, lastForceLogOut: String?
    let coin: String?

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
        case isForceLogOut = "is_force_log_out"
        case lastForceLogOut = "last_force_log_out"
        case coin
    }
}
