//
//  .swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit

extension String {
    static let welecomeDescriptionLabel = getLocalized(with: "welecomeDescriptionLabel")
    static let register = getLocalized(with: "register")
    static let guest = getLocalized(with: "guest")
    static let phoneDescriptionLabel = getLocalized(with: "phoneDescriptionLabel")
    static let country = getLocalized(with: "country")
    static let phoneNumber = getLocalized(with: "phoneNumber")
    static let getCode = getLocalized(with: "getCode")
    static let newUserDescriptionLabel = getLocalized(with: "newUserDescriptionLabel")
    static let fullName = getLocalized(with: "fullName")
    static let age = getLocalized(with: "age")
    static let gender = getLocalized(with: "gender")
    static let female = getLocalized(with: "female")
    static let male = getLocalized(with: "male")
    static let createAccount = getLocalized(with: "createAccount")
    static let otpDescriptionLabel = getLocalized(with: "otpDescriptionLabel")
    static let confirm = getLocalized(with: "confirm")
    static let newUser = getLocalized(with: "newUser")
    static let verification = getLocalized(with: "verification")
    
}

func getLocalized(with title: String) -> String {
    return NSLocalizedString(title, comment: "")
}
