//
//  OtpResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 07/01/23.
//

import Foundation

// MARK: - OtpResponse
struct OtpResponse: Codable {
    let success: Bool
    let message: String
    let parameters: OtpParameters?
}

// MARK: - Parameters
struct OtpParameters: Codable {
    let customer_id: String

}
