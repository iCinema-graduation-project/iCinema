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
    associatedtype Response where Response: Codable     // Associated type for the expected response type
    
    // Host and endpoint for the API request
    var host: String { get }
    var endpoint: String { get set }
    
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

extension APIRequest where Response: Codable {
    func request(method: HTTPMethod) -> AnyPublisher<DataResponse<Response, NetworkError>, Never> {
        return AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .publishDecodable(type: Response.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getErrorMessage(from error: NetworkError) -> String {
        
        if error.backendError == nil {
            return String(error.initialError.localizedDescription.split(separator: ":")[1])
        }
        
        return error.backendError!.message
    }
    
}
