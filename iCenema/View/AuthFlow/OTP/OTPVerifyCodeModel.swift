//
//  verifyCode.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/04/2023.
//

import Foundation

// MARK: - VerifyCode
struct VerifyCode: Codable {
    let key, msg: String
    let data: User
}
