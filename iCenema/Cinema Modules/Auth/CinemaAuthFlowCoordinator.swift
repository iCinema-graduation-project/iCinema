//
//  AuthFlowCoordinator.swift
//  ICinemaForCinemas
//
//  Created by Ahmed Yamany on 23/05/2023.
//

import UIKit
import Coordinator

class CinemaAuthFlowCoordinator: Coordinator {
    override init() {
        super.init()
        setViewControllers([
            SplashViewController.self,
            SignInViewController.self,
            CinemaTapBarController.self
        ])
    }
}
