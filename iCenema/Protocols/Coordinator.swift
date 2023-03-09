//
//  Coordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/02/2023.
//

import UIKit

enum CoordinatorType {
    case navigation
    case segue
}

// defines the expected behavior of coordinators,
// including managing a navigation controller and managing a stack of view controllers.
@objc protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var coordinators: [ViewController.Type] { get set }
    var currentIndex: Int { get set }
}

extension Coordinator {
    func push() {
        increaseCurrentIndex()
        
        let currentCoordinator = self.coordinators[currentIndex].init()
        currentCoordinator.coordinator = self
        
        if currentCoordinator.coordinatorType == .navigation {
            navigationController.pushViewController(currentCoordinator, animated: true)
        } else {
            if currentIndex <= 0{
                fatalError("you should not present segue at first ViewController at coordinator array")
            }
            guard let lastVC = navigationController.viewControllers.last as? ViewController else {return}
            lastVC.presentViewController(currentCoordinator)
        }
    }
    
    func pop() {
        decreaseCurrentIndex()
    }
    
    private func increaseCurrentIndex() {
         self.currentIndex = currentIndex == coordinators.count - 1 ? currentIndex : currentIndex + 1
     }
     
     private func decreaseCurrentIndex() {
         self.currentIndex = currentIndex == 0 ? 0 : currentIndex - 1
     }


}




