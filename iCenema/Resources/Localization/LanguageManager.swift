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
    static let follow = getLocalized(with: "follow")
    static let unfollow = getLocalized(with: "unfollow")
    static let bookNow = getLocalized(with: "bookNow")
    static let moreDetails = getLocalized(with: "moreDetails")
    static let next = getLocalized(with: "next")
    static let saveEdits = getLocalized(with: "saveEdits")
    static let profile = getLocalized(with: "profile")
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
    
    static let cinemaProfile = CinemaProfile.self
    struct CinemaProfile {
        static let followers = getLocalized(with: "cinemaProfile.followers")
        static let count = getLocalized(with: "cinemaProfile.count")
        
        static let size = getLocalized(with: "cinemaProfile.size")
        static let chairs = getLocalized(with: "cinemaProfile.chairs")
        
        static let location = getLocalized(with: "cinemaProfile.location")
        static let ratings = getLocalized(with: "cinemaProfile.ratings")
    }
    
    
    // MARK: - Home
    static let home = Home.self
    
    struct Home {
        static let forYou = getLocalized(with: "home.forYou")
    }
    
    // MARK: - Menu
    static let menu = Menu.self
    
    struct Menu {
        static let menu = getLocalized(with: "menu")
        static let general = getLocalized(with: "menu.general")
        static let following = getLocalized(with: "menu.following")
        static let activity = getLocalized(with: "menu.activity")
        static let saved = getLocalized(with: "menu.saved")
        static let icinemaWallet = getLocalized(with: "menu.icinemaWallet")
        static let language = getLocalized(with: "menu.language")
        static let lightMode = getLocalized(with: "menu.lightMode")
        static let darkMode = getLocalized(with: "menu.darkMode")
        
        static let service = getLocalized(with: "menu.service")
        static let contactUs = getLocalized(with: "menu.contactUs")
        static let aboutUs = getLocalized(with: "menu.aboutUs")
        static let rateUs = getLocalized(with: "menu.rateUs")
        static let logout = getLocalized(with: "menu.logout")
    }
    
    
    // MARK: - Booking
    static let booking = Booking.self
    struct Booking {
        static let pickADay = getLocalized(with: "booking.pickADay")
        static let pickATime = getLocalized(with: "booking.pickATime")
        static let pickAHall = getLocalized(with: "booking.pickAHall")
        static let pickApayment = getLocalized(with: "booking.pickApayment")
        static let creditCard = getLocalized(with: "booking.creditCard")
        static let eWallet = getLocalized(with: "booking.e-wallet")
        static let icinemaWallet = getLocalized(with: "booking.icinema-wallet")
        
        
    }
    
}

func getLocalized(with title: String) -> String {
    return NSLocalizedString(title, comment: "")
}
