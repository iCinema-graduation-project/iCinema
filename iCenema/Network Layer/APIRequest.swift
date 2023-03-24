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
var languageCode: String {
    Locale.current.languageCode ?? "en"
}

// Define a protocol for an API request
protocol APIRequest: AnyObject {
    
    // Associated type for the expected response type
    associatedtype Response where Response: Codable
    
    // Host and endpoint for the API request
    var host: String { get }
    var endpoint: String { get set }
    var requestMethod: HTTPMethod { get }
    
    // Optional parameters for the API request
    var parameters: Parameters? { get set }
    
}

// Default implementations for the APIRequest protocol
extension APIRequest {
    var host: String { "www.thesportsdb.com/api/v1/json/3/" }
    
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

// An extension for APIRequest that specifies a Codable Response type
extension APIRequest where Response: Codable {
    
    // A function that sends a request using the Alamofire library and returns a DataResponse object as a publisher
    func request() -> AnyPublisher<DataResponse<Response, NetworkError>, Never> {
        
        // Send a request using Alamofire
        return AF.request(url, method: requestMethod,
                          parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        
            // Validate the response
            .validate()
        
            // Decode the response as the specified Response type
            .publishDecodable(type: Response.self)
        
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
