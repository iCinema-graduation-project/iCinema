//
//  Movie.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import Foundation

// MARK: - Movie
struct Movie: Codable {
    let id: Int
    let image: String
    let cover: String?
    let name: String
    let saved: Bool
    let cinema: Cinema
}
