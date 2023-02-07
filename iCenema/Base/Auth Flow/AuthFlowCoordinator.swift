//
//  AuthFlowCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/02/2023.
//

import UIKit


final class AuthFlowCoordinator: Coordinator {
    
    var navigationController = UINavigationController()
    var coordinators: [ViewController.Type] = [PhoneViewController.self, OTPViewController.self, NewUserViewController.self]
    
    var currentIndex = 0
    
    init() {
        let welcomeVC = WelcomeViewController()
        welcomeVC.coordinator = self
                                        
        navigationController.setViewControllers([welcomeVC], animated: false)
    }
  
    func push() {
        let currentCoordinator = self.coordinators[currentIndex].init()
        currentCoordinator.coordinator = self
        self.increaseCurrentIndex()
        navigationController.pushViewController(currentCoordinator, animated: true)
    }
    
    func pop() {
        decreaseCurrentIndex()
    }
    
    private func increaseCurrentIndex() {
        currentIndex = currentIndex == coordinators.count - 1 ? currentIndex : currentIndex + 1
    }
    private func decreaseCurrentIndex() {
        currentIndex = currentIndex == 0 ? 0 : currentIndex - 1
    }

}
