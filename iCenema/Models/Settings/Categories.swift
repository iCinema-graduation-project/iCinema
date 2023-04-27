//
//  Categories.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/04/2023.
//

import Foundation

// MARK: - Categories
struct Categories: Codable {
    let key, msg: String
    let data: [CategoriesData]
}

// MARK: - Datum
struct CategoriesData: Codable {
    let id: Int
    let title: String
    let children: [Category]
}

struct Category: Codable, Equatable, Hashable{
    let id: Int
    let name: String
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }

}
