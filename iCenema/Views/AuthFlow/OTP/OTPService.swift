//
//  OTPService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 22/04/2023.
//

import Foundation

class OTPService: APIRequest {
    typealias DecodableType = VerifyCode

    lazy var networkRequest: Request = Request(endpoint: "verify-phone?_method=patch", method: .post, parameters: [
        "country_code": "20",
        "phone": phone,
        "code": code,
        "device_id": "dwdwedwwer",
        "device_type": "ios"
    ])
   
    let code: String
    let phone: String
    init(phone:String, code: String) {
        self.code = code
        self.phone = phone
    }
}
