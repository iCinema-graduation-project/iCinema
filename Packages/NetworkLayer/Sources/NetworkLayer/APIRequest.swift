
//  APIRequest.swift
//  iCinema
//
//  Created by Ahmed Yamany on 13/03/2023.
//
import Foundation
import Alamofire
import Combine
import SPAlert


/**
 This Protocol Defines The Behavior of Network Request
 * DecodableType: Associated type for the expected response type
 * networkRequest: object of NetworkRequest That manages the Parameters and other request needs
 * cancellableSet: any cancellable set to hold publishers' subscribers
 */
@available(iOS 13.0, *)
public protocol APIRequest {
    
    associatedtype DecodableType where DecodableType: Codable
    var networkRequest: NetworkRequest { get }
    var cancellableSet: Set<AnyCancellable> { get set }

}


@available(iOS 13.0, *)
extension APIRequest{
    
    /// Computed property that returns the full URL of the API request
    public var url: String{ "\(networkRequest.host)\(networkRequest.endpoint)" }
 
    
    /**
     * Takes: DataResponsePublisher as input.
     * Returns: A new publisher that maps any errors returned by the input publisher into instances of NetworkError.
     * 0. Try to decode a BackendError from the response data
     * 1. Checks if a BackendError is found, return a backendError NetworkError
     *    Otherwise, return an initialError NetworkError with the original error
     */
    private func mapError(with dataResponse: DataResponsePublisher<DecodableType>
        ) -> Publishers.Map<DataResponsePublisher<DecodableType>, DataResponse<DecodableType, NetworkError>> {
        
        return dataResponse.map { response in
            response.mapError { error in
                
                let networkError: NetworkError
                
                if let backendError = response.data.flatMap({ try? JSONDecoder().decode(BackendError.self, from: $0)}) {
                    networkError = .backendError(backendError)
                } else {
                    networkError = .initialError(error)
                }
                
                return networkError
            }
        }
    }
    
}


@available(iOS 13.0, *)
extension APIRequest {
    /**
     * 0. This Method Sends a request using the Alamofire library
     * 1. It Validates the response
     * 2. Decode the response as the specified Response type
     * 3. Maps The error to the NetworkError
     * 4. Receive the result on the main thread
     * 5. Erase and return a DataResponse object as a publisher
     */
    public func request() -> AnyPublisher<DataResponse<DecodableType, NetworkError>, Never> {
        // 0
        let request = AF.request(url, method: networkRequest.method,
                                 parameters: networkRequest.parameters,
                                 encoding: URLEncoding.queryString,
                                 headers: networkRequest.headers )
                        .validate() // 1
                        .publishDecodable(type: DecodableType.self) // 2
         
        return mapError(with: request) // 3
                .receive(on: DispatchQueue.main) // 4
                .eraseToAnyPublisher() //5
    }
    
}


@available(iOS 13.0, *)
extension APIRequest {
    /**
        The function makes a network request by calling the request function on self,
        which returns a DataResponsePublisher that represents the network request.
        The sink operator is then used to subscribe to the publisher and handle its output.
        When the publisher emits a value (which is a DataResponse object),
        the completion closure is called with that object as its argument.
     */
    public mutating func request(_ completion: @escaping (DataResponse<DecodableType, NetworkError>) -> Void) {
        self.request().sink { response in
            completion(response)
        }.store(in: &cancellableSet)
    }
    
    // cancels all the publishers stored in the cancellableSet
    public mutating func cancelAllPublishers() {
        self.cancellableSet.forEach { $0.cancel() }
        self.cancellableSet.removeAll()
    }

}



@available(iOS 13.0, *)
extension APIRequest {
    /**
     * Used to make a network request that contains multipart data
     *      (such as images, videos, or other binary data).
     *
     * It takes a dictionary of MultiPartType objects as input,
     *      where the keys represent the parameter names and the values of type MultiPartType holds the Data
     *
     * returns an Publisher object that represents the network request.
     *
     */
    public func request(multiPart: [String: MultiPartType]) -> AnyPublisher<DataResponse<DecodableType, NetworkError>, Never> {
        let request = AF.upload( multipartFormData: { self.update($0, with: multiPart) },
                                 to: self.url,
                                 method: networkRequest.method,
                                 headers: networkRequest.headers )
            .validate()
            .publishDecodable(type: DecodableType.self)
        
        return mapError(with: request)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /**
     Updates the multipart form data with the provided dictionary of values.
     
     - Parameters:
        - multiPartFormData: The `MultipartFormData` object to update.
        - multiPart: The dictionary of values to include in the multipart form data.
     */
    private func update(_ multiPartFormData: MultipartFormData, with multiPart: [String: MultiPartType]) {
        
        // Iterate over each key-value pair in the dictionary
        multiPart.forEach { key, value in
            
            // Generate a unique ID for the file
            let uuid = "\((arc4random_uniform(99999))+(arc4random_uniform(99999)))"
            
            // Construct the file name and MIME type for the file
            let fileName = "\(uuid).\(value.extention)"
            let mimeType = "\(value.type.rawValue)/\(value.extention)"
            
            // Add the file to the multipart form data
            multiPartFormData.append(value.data, withName: key, fileName: fileName, mimeType: mimeType)
        }
        
        // Update the multipart form data with any additional parameters
        self.update(multiPartFormData, with: self.networkRequest.parameters)
        
    }
    
    /**
     * Update the given `multiPartFormData` with the given `parameters`.
     *
     * - Parameters:
     *   - multiPartFormData: The `MultipartFormData` to update.
     *   - parameters: The parameters to add to the `multiPartFormData`.
     */
    private func update(_ multiPartFormData: MultipartFormData, with parameters: Parameters) {
        
        // Loop over each key-value pair in the `parameters` dictionary.
        for (key, value) in parameters {
            
            // If the value is an array, append each element to the form data with the same key name.
            if let value = value as? NSArray {
                let keyObj = key + "[]"
                for element in value {
                    self.append(element, to: keyObj, in: multiPartFormData)
                }
            }
            // Otherwise, append the single value to the form data with the given key name.
            else {
                self.append(value, to: key, in: multiPartFormData)
            }
        }
    }

    /**
     * Append the given `value` to the given `multiPartFormData` with the given `key`.
     *
     * - Parameters:
     *   - value: The value to append to the form data.
     *   - key: The key name for the value in the form data.
     *   - multiPartFormData: The `MultipartFormData` to append to.
     */
    private func append(_ value: Any, to key: String, in multiPartFormData: MultipartFormData) {
        let data = "\(value)".data(using: .utf8)!
        multiPartFormData.append(data, withName: key)
    }
    
}
    



