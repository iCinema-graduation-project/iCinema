//
//  ImageManager.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit


extension UIImage {
    static let welcomeImage: UIImage? = UIImage(named: "welcomeImage")
    static let profile = UIImage(named: "profile")
    static var magnifyingglass: UIImage { UIImage(systemName: "magnifyingglass")!}
    static let tabBar = TabBarImageManager()
    static let bookmark = UIImage(systemName: "bookmark")
    static let bookmarkFill = UIImage(systemName: "bookmark.fill")
    static let follow = UIImage(systemName: "person.badge.plus")
    static let unFollow = UIImage(systemName: "person.fill.badge.minus")
}

struct TabBarImageManager {
    let home = UIImage(named: "home")
    let homeSelected = UIImage(named: "homeS")
    let menu = UIImage(named: "menu")
    let menuSelected = UIImage(named: "menuS")
    let notification = UIImage(named: "notification")
    let notificationSelected = UIImage(named: "notificationS")
    let reels = UIImage(named: "reels")
    let reelsSelected = UIImage(named: "reelsS")
    let ticket = UIImage(named: "ticket")
    let ticketSelected = UIImage(named: "ticketS")
}


