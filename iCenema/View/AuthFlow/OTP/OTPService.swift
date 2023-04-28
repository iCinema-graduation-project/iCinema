//
//  OTPService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 22/04/2023.
//

import Foundation
import NetworkLayer
import Combine

class OTPService: APIRequest {
    typealias DecodableType = VerifyCode
    var cancellableSet: Set<AnyCancellable> = []
    

    lazy var networkRequest: NetworkRequest = NetworkRequest(endpoint: "verify-phone?_method=patch", method: .post)
   
}
