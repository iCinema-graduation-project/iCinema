//
//  BackendError.swift
//  
//
//  Created by Ahmed Yamany on 01/05/2023.
//

import Foundation

public struct BackendError: Codable, Error {
    var error: String
    var msg: String
}
