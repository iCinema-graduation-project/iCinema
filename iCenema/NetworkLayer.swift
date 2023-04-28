//
//  NetworkLayer.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/04/2023.
//

import Foundation
import NetworkLayer
import Combine

// Get the current language code for localization, defaulting to "en"
var appLanguageCode: String {
    Locale.current.languageCode ?? "en"
}

class NetworkLayer<T>: APIRequest where T: Codable {
    typealias DecodableType = T

    var networkRequest: NetworkRequest
    
    var cancellableSet: Set<AnyCancellable> = []
    
    init(networkRequest: NetworkRequest) {
        self.networkRequest = networkRequest
        self.updateNetworkRequest()
      
    }
    
    private func updateNetworkRequest() {
        
        self.networkRequest.update(parameters: ["device_id": deviceID, "device_type": "ios"])

        if let userToken = UserDefaults.standard.load(object: User.self, fromKey: .userDefaults.user)?.token{
            self.networkRequest.update(headers: ["Authorization": "Bearer \(userToken)"])
        }
                
        self.networkRequest.update(headers: [
            "Content-Type": "application/json",
            "lang": appLanguageCode
        ])
        
    }
    
}
