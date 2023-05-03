//
//  Home.swift
//  iCinema
//
//  Created by Ahmed Yamany on 29/04/2023.
//

import Foundation

// MARK: - HomeModel
struct HomeModel: Codable {
    let key, msg: String
    let data: HomeData?
}

// MARK: - DataClass
struct HomeData: Codable {
    let homeSlides: [HomeSlide]
    let categories: [HomeCategory]

    enum CodingKeys: String, CodingKey {
        case homeSlides = "home_slides"
        case categories
    }
}

// MARK: - HomeSlide
struct HomeSlide: Codable {
    let id: Int
    let type: HomeSlideType
    let movie: Movie?
    let cinema: Cinema?
    let image: String
}

enum HomeSlideType: String, Codable {
    case cinema
    case movie
}

// MARK: - Category
struct HomeCategory: Codable {
    let title, type: String
    let movies: [Movie]?
    let cinemas: [Cinema]?
}
