//
//  NotificationResponse.swift
//  EliteCake
//
//  Created by TechnoTackle on 11/08/23.
//

import Foundation

// MARK: - NotificationResponse
struct NotificationResponse: Codable {
    let success: Bool
    let message: String
    let parameters: [NotificationParameter]
}

// MARK: - Parameter
struct NotificationParameter: Codable {
    let customerID: String
    let template: String?
    let message, createdAt: String

    enum CodingKeys: String, CodingKey {
        case customerID = "customer_id"
        case template, message
        case createdAt = "created_at"
    }
}
