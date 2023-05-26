//
//  FollowingModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/05/2023.
//

import Foundation

struct FollowingModel: Codable {
    let key, msg: String
    let data: FollowingModelData
}

// MARK: - DataClass
struct FollowingModelData: Codable {
    let pagination: Pagination
    let cinemas: [Cinema]
}

