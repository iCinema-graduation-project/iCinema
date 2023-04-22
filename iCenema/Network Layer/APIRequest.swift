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
    var host: String = "http://localhost:8000/api/v1/"
    let endpoint: String
    let method: HTTPMethod
    var parameters: Parameters? = nil
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
    
    // Computed property that returns the headers for the API request
    private var headers: HTTPHeaders {
        var header = HTTPHeaders(["Content-Type": "application/json", "lang": appLanguageCode])
        
        if let userToken = UserDefaults.standard.load(object: User.self, fromKey: .userDefaults.user)?.token{
            header["Authorization"] = userToken
        }
        
        return header
    }
    
}

extension APIRequest {
    
    // A function that sends a request using the Alamofire library and returns a DataResponse object as a publisher
    func request() -> AnyPublisher<DataResponse<DecodableType, NetworkError>, Never> {
        print(url)
        // Send a request using Alamofire
        return AF.request(url, method: networkRequest.method,
                          parameters: networkRequest.parameters, encoding: URLEncoding.queryString)
        
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
