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
    let saved: Bool?
    let cinema: Cinema
    
    let trailer: String?
    let description, brief, releaseDate: String?
    let timeInMinutes, minAge, averageRate: Int?
    let countRate: Int?
    let rates: Rates?
    let categories: [Category]?
    let images: [MovieImage]?
    let related: [Movie]?

    let comments: [Comment]?

    
    enum CodingKeys: String, CodingKey {
        case id, image, cover, name, trailer, description, brief
        case releaseDate = "release_date"
        case timeInMinutes = "time_in_minutes"
        case minAge = "min_age"
        case countRate = "count_rate"
        case rates
        case related
        case images
        case averageRate = "average_rate"
        case categories, saved, cinema, comments
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


// MARK: - Rates
struct Rates: Codable, Hashable {
    let rate1, rate2, rate3: Int
    let rate4, rate5: Int

    enum CodingKeys: String, CodingKey, CaseIterable {
        case rate1 = "rate_1"
        case rate2 = "rate_2"
        case rate3 = "rate_3"
        case rate4 = "rate_4"
        case rate5 = "rate_5"
    }
}


// MARK: - Comment
struct Comment: Codable, Hashable {
    let id: Int
    let comment: String
    let user: RatingUser
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, comment, user
        case createdAt = "created_at"
    }
}

// MARK: - RatingUser
struct RatingUser: Codable, Hashable {
    let id: Int
    let image: String?
    let name: String
}
