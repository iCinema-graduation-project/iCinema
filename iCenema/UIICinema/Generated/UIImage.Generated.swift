//
//  ImageManager.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit.UIImage


extension UIImage {
    
    static let ICinemaLogo: UIImage = UIImage(named: "ICinemaLogo")!
    
    static let welcomeImage: UIImage = UIImage(named: "welcomeImage")!
    static let tabBar = TabBar.self
    
    static let bookmark = "bookmark"
    static let bookmarkFill = "bookmark.fill"
    static let location = "location"
    static let follow = "person.badge.plus"
    static let unFollow = "person.fill.badge.minus"
    
    static let shareIcon = UIImage(systemName: "square.and.arrow.up")!
    static let chairs = Chairs.self
    
    static let ticketsEmpty = "tickets.empty"
    
    struct TabBar {
        static let home = UIImage(named: "home")!
        static let homeSelected = UIImage(named: "homeS")!
        static let menu = UIImage(named: "menu")!
        static let menuSelected = UIImage(named: "menuS")!
        static let notification = UIImage(named: "notification")!
        static let notificationSelected = UIImage(named: "notificationS")!
        static let reels = UIImage(named: "reels")!
        static let reelsSelected = UIImage(named: "reelsS")!
        static let ticket = UIImage(named: "ticket")!
        static let ticketSelected = UIImage(named: "ticketS")!
    }


    struct Chairs {
        static let arch = UIImage(named: "arch")!
        static let premium = UIImage(named: "chairPremium")!
        static let booked = UIImage(named: "chairBooked")!
        static let ordinary = UIImage(named: "chairOrdinary")!
        static let selected = UIImage(named: "chairSelected")!
    }
    
    static let payment = Payment.self
    struct Payment {
        static let creditCard = UIImage(named: "credit-card")!
        static let eWallet = UIImage(named: "E-Wallet")!
        static let iCinemaWallet = UIImage(named: "icinema-Wallet")!
        static let visa = UIImage(named: "visa")!
    }
    
    static let cinemaUser = CinemaUser.self
    struct CinemaUser {
        static let scanQR = UIImage(named: "scanQR")!
        static let scanQRWhite = UIImage(named: "scanQR1")!
    }
    
}



