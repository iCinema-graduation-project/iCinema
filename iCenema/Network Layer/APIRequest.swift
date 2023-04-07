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
    var host: String = "thesportsdb.com/api/v1/json/3/"
    let endpoint: String
    let method: HTTPMethod
    var parameters: Parameters? = nil
}

// Define a protocol for an API request
protocol APIRequest: AnyObject {
    
    // Associated type for the expected response type
    associatedtype DecodableType where DecodableType: Codable
    
    var request: Request { get }
}


extension APIRequest{
    // Computed property that returns the full URL of the API request
    private var url: String{ "https://\(request.host)\(request.endpoint)" }
    
    // Computed property that returns the headers for the API request
    private var headers: HTTPHeaders {
        var header = HTTPHeaders(["Content-Type": "application/json", "lang": appLanguageCode])
        
        if let userToken = UserDefaults.standard.load(object: User.self, fromKey: .userDefaults.user)?.token{
            header["Authorization"] = userToken
        }
        
        return header
    }
    
}

// An extension for APIRequest that specifies a Codable Response type
extension APIRequest where DecodableType: Decodable {
    
    // A function that sends a request using the Alamofire library and returns a DataResponse object as a publisher
    func request() -> AnyPublisher<DataResponse<DecodableType, NetworkError>, Never> {
        print(url)
        // Send a request using Alamofire
        return AF.request(url, method: request.method,
                          parameters: request.parameters, encoding: URLEncoding.queryString, headers: headers)
        
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
    
    // A function that extracts an error message from a NetworkError object
    func getErrorMessage(from error: NetworkError) -> String {
        switch error {
            
        // If the error is a backendError, return the message from the BackendError object
        case .backendError(let error):
            return error.message
            
        // If the error is an initialError, split the localizedDescription and return the second part as the error message
        case .initialError(let error):
            return String(error.localizedDescription.split(separator: ":")[1])
        }
    }
    
}
