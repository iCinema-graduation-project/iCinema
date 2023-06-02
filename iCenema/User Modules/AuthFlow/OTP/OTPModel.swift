//
//  verifyCode.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/04/2023.
//

import Foundation

// MARK: - VerifyCode
struct VerifyCode: Codable {
    let key: accountStatus
    let msg: String
    let data: User
}


enum accountStatus: String, Codable {
    case compelete_data
    case success
}
