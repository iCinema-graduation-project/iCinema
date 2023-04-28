//
//  NetworkRequest.swift
//
//  Created by Ahmed Yamany on 27/04/2023.
//

import Foundation
import Alamofire


@available(iOS 13.0, *)
public struct NetworkRequest {
    public private(set) var host: String
    public private(set) var endpoint: String
    public private(set) var method: HTTPMethod
    public private(set) var parameters: Parameters
    public private(set) var headers: HTTPHeaders
    
    public init(host: String,
                endpoint: String,
                method: HTTPMethod,
                parameters: Parameters = [:],
                headers: HTTPHeaders = [:]) {
        
        self.host = host
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        self.headers = headers
    }
    
    public mutating func update(parameters: Parameters) {
        parameters.forEach { self.parameters[$0] = $1 }
    }
    
    public mutating func update(headers: [String: String]) {
        headers.forEach { self.headers.update(name: $0, value: $1) }
    }
}
