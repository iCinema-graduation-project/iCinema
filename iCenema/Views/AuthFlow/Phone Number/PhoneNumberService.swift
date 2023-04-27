//
//  PhoneNumberService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 20/04/2023.
//

import Foundation
import NetworkLayer

class PhoneNumberService: APIRequest {
    typealias DecodableType = Login
    
    let phone: String

    lazy var networkRequest: NetworkRequest = NetworkRequest(endpoint: "login",
                                               method: .post)

    init(phone: String) {
        self.phone = phone
        networkRequest.parameters = [
            "country_code": "20",
            "phone": phone,
            "device_id": "dwdwedwwer",
            "device_type": "ios"
           ]
    }
    
}
