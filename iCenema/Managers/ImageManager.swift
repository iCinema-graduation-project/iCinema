//
//  ImageManager.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit

struct ImageManager {
    static let welcomeImage: UIImage? = UIImage(named: "welcomeImage")
    static let female: UIImage? = UIImage(named: "female")
    static let male:UIImage? = UIImage(named: "male")
    static let tabBar = TabBarImageManager()
}


struct TabBarImageManager {
    let home = UIImage(named: "home")
    let homeSelected = UIImage(named: "homeS")
    let menu = UIImage(named: "menu")
    let menuSelected = UIImage(named: "menuS")
    let notigication = UIImage(named: "notification")
    let notigicationSelected = UIImage(named: "notificationS")
    let reels = UIImage(named: "reels")
    let reelsSelected = UIImage(named: "reelsS")
    let ticket = UIImage(named: "ticket")
    let ticketSelected = UIImage(named: "ticketS")
}
