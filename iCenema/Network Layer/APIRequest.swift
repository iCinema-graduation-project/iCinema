//
//  APIRequest.swift
//  iCinema
//
//  Created by Ahmed Yamany on 13/03/2023.
//
import Foundation
import Alamofire

// Get the current language code for localization, defaulting to "en"
var languageCode: String {
    Locale.current.languageCode ?? "en"
}

// Define a protocol for an API request
protocol APIRequest {
    associatedtype Response     // Associated type for the expected response type
    
    // Host and endpoint for the API request
    var host: String { get set }
    var endpoint: String { get set }
    
    // Optional parameters for the API request
    var parameters: Parameters? { get set }
}

// Default implementations for the APIRequest protocol
extension APIRequest {
    var host: String { "" }
    private var userToken: String? {
        UserDefaults.standard.load(object: User.self, fromKey: .userDefaults.user)?.token
    }
}

extension APIRequest{
    // Computed property that returns the full URL of the API request
    private var url: String{ "https://\(host)\(endpoint)" }
    
    // Computed property that returns the headers for the API request
    private var headers: HTTPHeaders {
        var header = HTTPHeaders(["Content-Type": "application/json", "lang": languageCode])
        
        if let userToken = userToken{
            header["Authorization"] = userToken
        }
        
        return header
    }
}

extension APIRequest where Response: Decodable {
    private func request(method: HTTPMethod, _ completion: @escaping (DataResponse<Self.Response, AFError>) -> Void ) {
        AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseDecodable(of: Response.self) { response in
            completion(response)
        }
    }
    
    func get(completion: @escaping (DataResponse<Self.Response, AFError>) -> Void ) {
        request(method: .get, completion)
    }
    
    func post(completion: @escaping (DataResponse<Self.Response, AFError>) -> Void ) {
        request(method: .post, completion)
    }
    
}
