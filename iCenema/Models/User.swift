//
//  User.swift
//  iCinema
//
//  Created by Ahmed Yamany on 13/03/2023.
//

import Foundation

// MARK: - Welcome
struct Login: Decodable {
    let key, msg: String?
    let data: User
}


// MARK: - User
struct User: Decodable {
    let id: Int
    let name: String?
    let countryCode, phone, fullPhone: String
    let image: String
    let dob, age: Int?
    let gender: String?
    let token: String
    let lat, lng: String?
    let address: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case countryCode = "country_code"
        case phone
        case fullPhone = "full_phone"
        case image, dob, age, gender, token, lat, lng, address
    }
}
