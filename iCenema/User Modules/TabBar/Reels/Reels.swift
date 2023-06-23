//
//  Reels.swift
//  iCinema
//
//  Created by Ahmed Yamany on 21/06/2023.
//

import Foundation


struct Reels: Codable {
    let key: String
    let msg: String
    let data: ReelsData
}

struct ReelsData: Codable {
    let reels_count: Int
    let reels: [IGStory]
}
