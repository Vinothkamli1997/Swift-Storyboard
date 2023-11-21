//
//  SetDelTypeApi.swift
//  EliteCake
//
//  Created by Apple - 1 on 02/05/23.
//

import Foundation


// MARK: - SetDelTypeResponse
struct SetDelTypeResponse: Codable {
    let success: Bool
    let message: String
    let parameters: String?
}
