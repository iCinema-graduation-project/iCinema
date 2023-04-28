//
//  PhoneNumberService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 20/04/2023.
//

import Foundation
import NetworkLayer

class PhoneNumberLoginService: NetworkLayer<Login> {

    init() {
        super.init(networkRequest: NetworkRequest(endpoint: "login", method: .post))
    }
    
}
