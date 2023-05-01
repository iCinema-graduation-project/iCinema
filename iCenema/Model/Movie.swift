//
//  Movie.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import Foundation

// MARK: - Movie
struct Movie: Codable, Equatable, Hashable {
    let id: Int
    let image: String
    let cover: String?
    let name: String
    let saved: Bool
    let cinema: Cinema
    
    let trailer: String?
    let description, brief, releaseDate: String?
    let timeInMinutes, minAge, averageRate: Int?
    let categories: [Category]?
    let images: [MovieImage]?
    
    let comments: [String]?

    
    enum CodingKeys: String, CodingKey {
        case id, image, cover, name, trailer, description, brief
        case releaseDate = "release_date"
        case timeInMinutes = "time_in_minutes"
        case minAge = "min_age"
        case averageRate = "average_rate"
        case categories, saved, images, cinema, comments
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
}


// MARK: - Image
struct MovieImage: Codable, Hashable, Equatable {
    let id: Int
    let image: String
    
    static func == (lhs: MovieImage, rhs: MovieImage) -> Bool {
        lhs.id == rhs.id
    }
}
