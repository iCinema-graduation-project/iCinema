//
//  OTPService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 22/04/2023.
//

import NetworkLayer

class OTPService: NetworkLayer<VerifyCode> {

    init() {
        super.init(networkRequest: NetworkRequest(endpoint: "verify-phone?_method=patch", method: .post))
    }
}
