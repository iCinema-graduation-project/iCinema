//
//  AuthFlowCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/02/2023.
//

import UIKit


final class AuthFlowCoordinator: Coordinator {

    override init() {
        super.init()
        coordinators = [WelcomeViewController.self, PhoneViewController.self,
                        OTPViewController.self,
                        AppTapBarController.self]
        push()
    }

}
