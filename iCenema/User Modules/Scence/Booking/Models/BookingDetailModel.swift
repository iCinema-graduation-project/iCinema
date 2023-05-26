//
//  BookingDetail.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/05/2023.
//

import Foundation

// MARK: - BookingDetailModel
struct BookingDetailModel: Codable {
    let key, msg: String
    let dates: [BookingDate]
    
    enum CodingKeys: String, CodingKey {
        case key, msg
        case dates = "data"
    }
}

// MARK: - Datum
struct BookingDate: Codable, Hashable {
    let id: Int
    let isoDate: String
    let times: [Time]
    enum CodingKeys: String, CodingKey {
        case id
        case isoDate = "date"
        case times
    }
    
    
    static func == (lhs: BookingDate, rhs: BookingDate) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Time
struct Time: Codable, Hashable {
    let id: Int
    let premiumPrice: Int?
    let price: Int?
    let time: String
    let seats: [[Seat]]

    enum CodingKeys: String, CodingKey {
        case id = "time_view_id"
        case premiumPrice = "premium_price"
        case price, time, seats
    }
    
    static func == (lhs: Time, rhs: Time) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Seat
struct Seat: Codable, Hashable {
    let status: Status
    let price: Int?
}

enum Status: String, Codable {
    case empity = "empity"
    case normal = "normal"
}
