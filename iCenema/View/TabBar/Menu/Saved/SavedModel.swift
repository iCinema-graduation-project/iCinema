//
//  SavedModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 02/05/2023.
//

import Foundation


struct SavedModel: Codable {
    let key, msg: String
    let data: SavedModelData
}

// MARK: - DataClass
struct SavedModelData: Codable {
    let pagination: Pagination
    let movies: [Movie]
}
