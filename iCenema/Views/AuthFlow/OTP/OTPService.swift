//
//  OTPService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 22/04/2023.
//

import Foundation
import NetworkLayer

class OTPService: APIRequest {
    typealias DecodableType = VerifyCode

    lazy var networkRequest: NetworkRequest = NetworkRequest(endpoint: "verify-phone?_method=patch", method: .post)
   
    let code: String
    let phone: String
    init(phone:String, code: String) {
        self.code = code
        self.phone = phone
        networkRequest.parameters =  [
            "country_code": "20",
            "phone": phone,
            "code": code,
            "device_id": "dwdwedwwer",
            "device_type": "ios"
        ]
    }
}
