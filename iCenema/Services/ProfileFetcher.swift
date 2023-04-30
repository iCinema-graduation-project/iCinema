//
//  ProfileService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/04/2023.
//

import Foundation
import NetworkLayer

class ProfileFetcher: NetworkLayer<ProfileModel> {

    init() {
        super.init(endpoint: "profile", method: .get)
    }
    
}
