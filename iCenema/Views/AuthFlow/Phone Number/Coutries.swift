//
//  Coutries.swift
//  iCinema
//
//  Created by Ahmed Yamany on 16/03/2023.
//

import Foundation


// MARK: - Countries
struct Countries: Codable {
    let list: [Country]
    
    enum CodingKeys: String, CodingKey {
        case list = "countries"
    }

}

// MARK: - Country
struct Country: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "name_en"
    }
}
