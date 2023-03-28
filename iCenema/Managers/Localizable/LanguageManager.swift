//
//  .swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit

extension String {
    static let register = getLocalized(with: "register")
    static let view = getLocalized(with: "view")
    static let cinemas = getLocalized(with: "cinemas")
    
    // MARK: - Auth Flow
    static let welcome = Welcome.self
    static let phone = Phone.self
    static let otp = OTP.self
    static let newUser = NewUser.self
    
    struct Welcome {
        static let descriptionLabel = getLocalized(with: "welecome.descriptionLabel")
        static let guest = getLocalized(with: "welecome.guest")
    }
    
    struct Phone {
        static let descriptionLabel = getLocalized(with: "phone.descriptionLabel")
        static let country = getLocalized(with: "phone.country")
        static let phoneNumber = getLocalized(with: "phone.phoneNumber")
        static let getCode = getLocalized(with: "phone.getCode")
        static let errorMessage = getLocalized(with: "phone.errorMessage")
    }
    
    struct OTP {
        static let descriptionLabel = getLocalized(with: "otp.descriptionLabel")
        static let confirm = getLocalized(with: "otp.confirm")
        static let verification = getLocalized(with: "otp.verification")
    }
    
    struct NewUser {
        static let descriptionLabel = getLocalized(with: "newUser.descriptionLabel")
        static let fullName = getLocalized(with: "newUser.fullName")
        static let age = getLocalized(with: "newUser.age")
        static let gender = getLocalized(with: "newUser.gender")
        static let female = getLocalized(with: "newUser.female")
        static let male = getLocalized(with: "newUser.male")
        static let createAccount = getLocalized(with: "newUser.createAccount")
        static let newUser = getLocalized(with: "newUser.newUser")
    }
    
    // MARK: - Home
    static let home = Home.self
    
    struct Home {
        static let forYou = getLocalized(with: "home.forYou")
    }
    
}

func getLocalized(with title: String) -> String {
    return NSLocalizedString(title, comment: "")
}
