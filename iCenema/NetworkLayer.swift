//
//  NetworkLayer.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/04/2023.
//

import Foundation
import NetworkLayer
import Combine
import Alamofire

// Get the current language code for localization, defaulting to "en"
var appLanguageCode: String {
    Locale.current.languageCode ?? "en"
}

class NetworkLayer<T>: APIRequest where T: Codable {
    typealias DecodableType = T

    var networkRequest: NetworkRequest
    
    var cancellableSet: Set<AnyCancellable> = []
    
    init( endpoint: String, method: HTTPMethod) {
        self.networkRequest = .init(host: "http://icinema.live/api/v1/",
                                    endpoint: endpoint, method: method)
        
        self.updateNetworkRequest()
    }
    
    private func updateNetworkRequest() {
        if self.networkRequest.method == .post {
            self.networkRequest.update(parameters: ["device_id": deviceID, "device_type": "ios"])
        }

        if let userToken = UserDefaults.standard.load(object: User.self, fromKey: .user)?.token{
            self.networkRequest.update(headers: ["Authorization": "Bearer \(userToken)"])
        }
                
        self.networkRequest.update(headers: [
            "Content-Type": "application/json",
            "lang": appLanguageCode
        ])
        
        
    }
    
}
