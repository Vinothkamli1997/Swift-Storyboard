//
//  ForceUpdateResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 28/06/23.
//

import Foundation

// MARK: - ForceUpdateResponse
struct ForceUpdateResponse: Codable {
    let success: Bool
    let message: String
    let parameters: ForceUpdateParameters
}

// MARK: - Parameters
struct ForceUpdateParameters: Codable {
    let appVersion: AppVersion

    enum CodingKeys: String, CodingKey {
        case appVersion = "app_version"
    }
}

// MARK: - AppVersion
struct AppVersion: Codable {
    let id, osType, currentVersion: String
    let forceUpdate: Bool
    let createdAt, merchantID: String

    enum CodingKeys: String, CodingKey {
        case id
        case osType = "os_type"
        case currentVersion = "current_version"
        case forceUpdate = "force_update"
        case createdAt = "created_at"
        case merchantID = "merchant_id"
    }
}
