//
//  ProfileEditResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 25/05/23.
//

import Foundation

// MARK: - ProfileEditResponse
struct ProfileEditResponse: Codable {
    let success: Bool
    let message: String
    let parameters: ProfileEditParameters
}

// MARK: - Parameters
struct ProfileEditParameters: Codable {
    let message: String
}
