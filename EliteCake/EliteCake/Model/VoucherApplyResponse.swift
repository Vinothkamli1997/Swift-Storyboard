//
//  VoucherApplyResponse.swift
//  EliteCake
//
//  Created by Apple - 1 on 03/05/23.
//

import Foundation

// MARK: - VoucherApplyResponse
struct VoucherApplyResponse: Codable {
    let success: Bool
    let message: String
    let parameters: JSONNull?
}

