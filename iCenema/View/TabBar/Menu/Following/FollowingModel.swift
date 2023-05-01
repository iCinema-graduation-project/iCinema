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


// MARK: - Pagination
struct Pagination: Codable {
    let totalItems, countItems, perPage, totalPages: Int
    let currentPage: Int
    let nextPageURL, pervPageURL: String

    enum CodingKeys: String, CodingKey {
        case totalItems = "total_items"
        case countItems = "count_items"
        case perPage = "per_page"
        case totalPages = "total_pages"
        case currentPage = "current_page"
        case nextPageURL = "next_page_url"
        case pervPageURL = "perv_page_url"
    }
}
