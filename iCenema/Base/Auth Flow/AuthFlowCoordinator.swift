//
//  AuthFlowCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/02/2023.
//

import UIKit


final class AuthFlowCoordinator: Coordinator {    
    var navigationController: UINavigationController = .init(nibName: nil, bundle: nil)
    var coordinators: [ViewController.Type] = [WelcomeViewController.self, PhoneViewController.self, OTPViewController.self,
                                               NewUserViewController.self, AppTapBarController.self]
    
    init() {
        push()
    }

}
