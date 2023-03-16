//
//  Error.swift
//  iCinema
//
//  Created by Ahmed Yamany on 16/03/2023.
//

import Foundation
import Alamofire

struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}
