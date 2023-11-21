//
//  DiscartCartResponse.swift
//  EliteCake
//
//  Created by TechnoTackle on 08/09/23.
//

import Foundation


struct DiscartResponse: Codable {
    let success: Bool
    let message: String
    let parameters: String?
}
