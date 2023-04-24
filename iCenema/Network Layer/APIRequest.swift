//
//  APIRequest.swift
//  iCinema
//
//  Created by Ahmed Yamany on 13/03/2023.
//
import Foundation
import Alamofire
import Combine


// Get the current language code for localization, defaulting to "en"
var appLanguageCode: String {
    Locale.current.languageCode ?? "en"
}

struct Request {
    var host: String
    let endpoint: String
    let method: HTTPMethod
    var parameters: Parameters? = nil
    
    var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "lang": appLanguageCode
        ]
    
    init(host: String = "http://localhost:8000/api/v1/",
         endpoint: String,
         method: HTTPMethod,
         parameters: Parameters? = nil) {
        self.host = host
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        
        if let userToken = UserDefaults.standard.load(object: User.self, fromKey: .userDefaults.user)?.token{
            self.headers["Authorization"] = "Bearer \(userToken)"
        }

    }

}

// Define a protocol for an API request
protocol APIRequest: AnyObject {
    
    // Associated type for the expected response type
    associatedtype DecodableType where DecodableType: Decodable
    
    var networkRequest: Request { get }
    
}


extension APIRequest{
    // Computed property that returns the full URL of the API request
    private var url: String{ "\(networkRequest.host)\(networkRequest.endpoint)" }
 
}

extension APIRequest {
    
    // A function that sends a request using the Alamofire library and returns a DataResponse object as a publisher
    func request() -> AnyPublisher<DataResponse<DecodableType, NetworkError>, Never> {
        print(url)
        // Send a request using Alamofire
        return AF.request(url, method: networkRequest.method,
                          parameters: networkRequest.parameters,
                          encoding: URLEncoding.queryString,
                          headers: networkRequest.headers)
        
            // Validate the response
            .validate()
        
            // Decode the response as the specified Response type
            .publishDecodable(type: DecodableType.self)
            // Map errors to NetworkError types
            .map { response in
                response.mapError { error in

                    // Try to decode a BackendError from the response data
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}

                    // If a BackendError is found, return a backendError NetworkError
                    if let backendError = backendError {
                        return .backendError(backendError)
                    }

                    // Otherwise, return an initialError NetworkError with the original error
                    else {
                        return .initialError(error)
                    }
                    
                }

            }
            
            // Receive the result on the main thread
            .receive(on: DispatchQueue.main)
        
            // Erase the type of the publisher to AnyPublisher<DataResponse<Response, NetworkError>, Never>
            .eraseToAnyPublisher()
    }
    
    
}
