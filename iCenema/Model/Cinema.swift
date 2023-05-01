//
//  Cinema.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import Foundation
import Combine

// MARK: - Cinema
struct Cinema: Codable, Equatable, Hashable {
    let id: Int
    let logo: String
    let cover: String?
    let name: String
    let following: Bool?
    let averageRate: Int?
    let countFollow: Int?
    let address, distance: String?
    
    let images: [CinemaImage]?
    let movies: [CinemaMovie]?
    
    enum CodingKeys: String, CodingKey {
        case id, logo, cover, name, following
        case averageRate = "average_rate"
        case address, distance, images, movies
        case countFollow = "count_follow"

    }
    
    static func == (lhs: Cinema, rhs: Cinema) -> Bool {
        lhs.id == rhs.id
    }
}


// MARK: - Image
struct CinemaImage: Codable, Hashable {
    let id: Int
    let image: String
}

// MARK: - Movie
struct CinemaMovie: Codable, Hashable {
    let id: Int
    let image, cover: String
    let name: String
}
