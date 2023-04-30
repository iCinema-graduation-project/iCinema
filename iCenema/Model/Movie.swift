//
//  Movie.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import Foundation

// MARK: - Movie
struct Movie: Codable, Equatable {
    let id: Int
    let image: String
    let cover: String?
    let name: String
    let saved: Bool
    let cinema: Cinema
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
}
