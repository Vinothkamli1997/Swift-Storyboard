//
//  AddEmailResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 31/05/23.
//

import Foundation


// MARK: - AddEmailResponse
struct AddEmailResponse: Codable {
    let success: Bool
    let message: String
    let parameters: String?
}
