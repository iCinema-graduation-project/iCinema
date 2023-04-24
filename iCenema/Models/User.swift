//
//  User.swift
//  iCinema
//
//  Created by Ahmed Yamany on 13/03/2023.
//

import Foundation


// MARK: - User
struct User: Codable {
    let id: Int?
    let name: String?
    let countryCode, phone: String
    let image: String?
    let dob: String?
    let age: Int?
    let gender: String?
    let token: String
    let lat, lng, address: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case countryCode = "country_code"
        case phone, image, dob, age, gender, token, lat, lng, address
    }}
