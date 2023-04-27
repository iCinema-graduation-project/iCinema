
//  APIRequest.swift
//  iCinema
//
//  Created by Ahmed Yamany on 13/03/2023.
//
import Foundation
import Alamofire
import Combine
import SPAlert


// Define a protocol for an API request
@available(iOS 13.0, *)
public protocol APIRequest {
    
    // Associated type for the expected response type
    associatedtype DecodableType where DecodableType: Decodable
    
    var networkRequest: NetworkRequest { get }
    
}

@available(iOS 13.0, *)
extension APIRequest{
    // Computed property that returns the full URL of the API request
    public var url: String{ "\(networkRequest.host)\(networkRequest.endpoint)" }
 
}

@available(iOS 13.0, *)
extension APIRequest {
    
    // A function that sends a request using the Alamofire library and returns a DataResponse object as a publisher
    public func request() -> AnyPublisher<DataResponse<DecodableType, NetworkError>, Never> {
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
                    let networkError: NetworkError
                    
                    // Try to decode a BackendError from the response data
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}

                    // If a BackendError is found, return a backendError NetworkError
                    if let backendError = backendError {
                        networkError = .backendError(backendError)
                    }

                    // Otherwise, return an initialError NetworkError with the original error
                    else {
                        networkError = .initialError(error)
                    }

                    return networkError
                }

            }
            
            // Receive the result on the main thread
            .receive(on: DispatchQueue.main)
        
            // Erase the type of the publisher to AnyPublisher<DataResponse<Response, NetworkError>, Never>
            .eraseToAnyPublisher()
    }
    
    
}
