//
//  PhoneNumberService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 20/04/2023.
//

import Foundation
import NetworkLayer
import Combine

class PhoneNumberLoginService: APIRequest {

    typealias DecodableType = Login

    var cancellableSet: Set<AnyCancellable> = []
    
    var networkRequest: NetworkRequest = NetworkRequest(endpoint: "login", method: .post)

    init() {
        self.updateParameters()
    }
    
    
    private func updateParameters() {
        networkRequest.parameters = [
            "country_code": "20",
            "device_id": deviceID,
            "device_type": "ios"
           ]
    }
    
}
