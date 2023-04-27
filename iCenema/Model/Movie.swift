//
//  Movie.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import Foundation

struct Movie: Decodable {
    let poster: String
    let name: String
    var bookmarket: Bool
}
