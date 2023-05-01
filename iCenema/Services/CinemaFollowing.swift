//
//  CinemaFollowing.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/05/2023.
//

import Foundation

class CinemaFollowing: NetworkLayer<CinemaFollowingModel> {
    
    init() {
        super.init(endpoint: "cinemas/follow-and-unfollow", method: .post)
    }
    
    public func update(id: Int) {
        self.networkRequest.update(parameters: ["id": id])
    }
}
