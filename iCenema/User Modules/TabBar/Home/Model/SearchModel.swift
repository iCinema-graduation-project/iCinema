//
//  SearchModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/06/2023.
//

import Foundation

struct SearchModel: Codable {
    let key, msg: String
    let data: SearchModelData
}

// MARK: - SearchModelData
struct SearchModelData: Codable {
    let pagination: Pagination
    let movies: [Movie]
}
