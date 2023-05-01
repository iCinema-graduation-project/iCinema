//
//  Error.swift
//  iCinema
//
//  Created by Ahmed Yamany on 16/03/2023.
//

import Foundation
import Alamofire

public enum NetworkError: Error {
    case initialError(AFError)
    case backendError(BackendError)
    case other
    
    // A function that extracts an error message from a NetworkError object
    public static func getErrorMessage(from error: NetworkError) -> String {
        switch error {
            
        // If the error is a backendError, return the message from the BackendError object
        case .backendError(let error):
            return error.msg
            
        // If the error is an initialError, split the localizedDescription and return the second part as the error message
        case .initialError(let error):
//            return String(error.localizedDescription.split(separator: ":")[1])
            return String(error.localizedDescription)
        case .other:
            return "unKnown Error"
        }
    }

}

