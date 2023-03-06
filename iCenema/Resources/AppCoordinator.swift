//
//  AppCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/02/2023.
//

import UIKit

var isAuthed = true

class AppCoordinator {
    var rootViewController: UIViewController
    
    init() {
        
        if isAuthed {
//            rootViewController = AppTapBarController()
            rootViewController = CinemaProfileViewController()
        } else {
            let appFlowCoordinator = AuthFlowCoordinator()
            rootViewController = appFlowCoordinator.navigationController
        }
    }
    
}
