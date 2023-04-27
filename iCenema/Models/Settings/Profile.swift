//
//  Profile.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/04/2023.
//

import Foundation

// MARK: - Profile
struct Profile: Codable {
    let key, msg: String?
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case key, msg
        case user = "data"
    }
}
