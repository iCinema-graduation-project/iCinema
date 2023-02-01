//
//  LanguageManager.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit

struct LanguageManager {
    static let welecomeDescriptionLabel = LanguageManager.getLocalized(with: "welecomeDescriptionLabel")
    static let register = LanguageManager.getLocalized(with: "register")
    static let guest = LanguageManager.getLocalized(with: "guest")
    static let phoneDescriptionLabel = LanguageManager.getLocalized(with: "phoneDescriptionLabel")
    static let country = LanguageManager.getLocalized(with: "country")
    static let phoneNumber = LanguageManager.getLocalized(with: "phoneNumber")
    static let getCode = LanguageManager.getLocalized(with: "getCode")
    static let newUserDescriptionLabel = LanguageManager.getLocalized(with: "newUserDescriptionLabel")
    static let fullName = LanguageManager.getLocalized(with: "fullName")
    static let age = LanguageManager.getLocalized(with: "age")
    static let gender = LanguageManager.getLocalized(with: "gender")
    static let female = LanguageManager.getLocalized(with: "female")
    static let male = LanguageManager.getLocalized(with: "male")
    static let createAccount = LanguageManager.getLocalized(with: "createAccount")
    static let otpDescriptionLabel = LanguageManager.getLocalized(with: "otpDescriptionLabel")
    static let confirm = LanguageManager.getLocalized(with: "confirm")
    static let newUser = LanguageManager.getLocalized(with: "newUser")
    static let verification = LanguageManager.getLocalized(with: "verification")
    
    
    
    static func getLocalized(with title: String) -> String {
        return NSLocalizedString(title, comment: "")
    }
}
