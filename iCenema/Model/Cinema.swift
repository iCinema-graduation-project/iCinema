//
//  Cinema.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import Foundation

// MARK: - Cinema
struct Cinema: Codable, Equatable {
    let id: Int
    let logo: String
    let cover: String?
    let name: String
    let following: Bool
    let averageRate: Int
    let address, distance: String?
    
    enum CodingKeys: String, CodingKey {
        case id, logo, cover, name, following
        case averageRate = "average_rate"
        case address, distance
    }
    
    static func == (lhs: Cinema, rhs: Cinema) -> Bool {
        lhs.id == rhs.id
    }
}

