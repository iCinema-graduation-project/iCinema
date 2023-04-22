//
//  OTPService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 22/04/2023.
//

import Foundation

class OTPService: APIRequest {
    typealias DecodableType = User

    var networkRequest: Request = Request(endpoint: "login", method: .post, parameters: nil)
   
}
