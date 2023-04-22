//
//  PhoneNumberService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 20/04/2023.
//

import Foundation


class PhoneNumberService: APIRequest {
    typealias DecodableType = Login
    
    let phone: String

    lazy var networkRequest: Request = Request(endpoint: "login", method: .post, parameters: [
        "country_code": "20",
        "phone": phone,
        "device_id": "dwdwedwwer",
        "device_type": "ios"
    ])

    init(phone: String) {
        self.phone = phone
        print(phone)
    }
    
}
