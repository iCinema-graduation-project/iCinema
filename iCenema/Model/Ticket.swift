//
//  Ticket.swift
//  iCinema
//
//  Created by Ahmed Yamany on 15/04/2023.
//

import Foundation


// MARK: - Welcome
struct TicketsModel: Codable {
    let key, msg: String
    let data: TicketsData
}

// MARK: - DataClass
struct TicketsData: Codable {
    let data: [Ticket]
}

// MARK: - Datum
struct Ticket: Codable, Identifiable {
    let id: String?
    let seats: [TicketSeat]
    let start, startsAfter, end: String
    let price: String?
    let movie: Movie

    enum CodingKeys: String, CodingKey {
        case id, seats, start
        case startsAfter = "starts_after"
        case end, price, movie
    }
}

struct TicketSeat: Codable {
    let id: Int
    let name: String
}
