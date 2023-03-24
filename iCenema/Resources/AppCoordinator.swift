//
//  AppCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/02/2023.
//

import UIKit

var isAuthed = false

class AppCoordinator {
    var rootViewController: UIViewController
    
    init() {
        
        if isAuthed {
            rootViewController = AppTapBarController()
        } else {
            let appFlowCoordinator = AuthFlowCoordinator()
            rootViewController = appFlowCoordinator.navigationController
        }
    }
    
}
