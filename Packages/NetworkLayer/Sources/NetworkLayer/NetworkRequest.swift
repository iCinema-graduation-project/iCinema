//
//  NetworkRequest.swift
//
//  Created by Ahmed Yamany on 27/04/2023.
//

import Foundation
import Alamofire

// Get the current language code for localization, defaulting to "en"
//var appLanguageCode: String {
//    Locale.current.languageCode ?? "en"
//}

@available(iOS 13.0, *)
public struct NetworkRequest {
    public var host: String
    public let endpoint: String
    public let method: HTTPMethod
    public var parameters: Parameters? = nil
    
    public var headers: HTTPHeaders = [
        "Content-Type": "application/json",
//        "lang": appLanguageCode
    ]
    
    public init(host: String = "http://localhost:8000/api/v1/",
         endpoint: String,
         method: HTTPMethod,
         parameters: Parameters? = nil) {
        self.host = host
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        
//        if let userToken = UserDefaults.standard.load(object: User.self, fromKey: .userDefaults.user)?.token{
//            self.headers["Authorization"] = "Bearer \(userToken)"
//        }
        
    }
    
}
