//
//  Error.swift
//  iCinema
//
//  Created by Ahmed Yamany on 16/03/2023.
//

import Foundation
import Alamofire

enum NetworkError: Error {
  case initialError(AFError)
  case backendError(BackendError)
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
