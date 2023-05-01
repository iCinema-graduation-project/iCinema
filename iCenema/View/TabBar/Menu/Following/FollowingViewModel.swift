//
//  FollowingViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/05/2023.
//

import Foundation

class FollowingViewModel {
    var service: NetworkLayer<FollowingModel> = .init(endpoint: "cinemas/following", method: .get)
}
