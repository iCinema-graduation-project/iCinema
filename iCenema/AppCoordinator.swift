//
//  AppCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/02/2023.
//

import UIKit


class AppCoordinator {
    var rootViewController: UIViewController
    var isAuthed = false

    init() {
        if let _ = UserDefaults.standard.load(object: User.self, fromKey: .user) {
            isAuthed = true
        }
        
        if isAuthed {
            rootViewController = AppTapBarController()
        } else {
            let appFlowCoordinator = AuthFlowCoordinator()
            rootViewController = appFlowCoordinator.navigationController
        }
    }
    
}
