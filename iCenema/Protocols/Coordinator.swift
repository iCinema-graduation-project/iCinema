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
 class Coordinator {
    var navigationController: UINavigationController = .init(nibName: nil, bundle: nil)
    var coordinators: [ViewController.Type]  = []
    var currentIndex: Int = -1

    func push(userInfo: [String: Any]? = nil ) {
        increaseCurrentIndex()
        
        let currentCoordinator = self.coordinators[currentIndex].init()
        currentCoordinator.userInfo = userInfo
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
        print(currentIndex)
        decreaseCurrentIndex()
    }
    
    private func increaseCurrentIndex() {
         self.currentIndex = currentIndex == coordinators.count - 1 ? currentIndex : currentIndex + 1
     }
     
     private func decreaseCurrentIndex() {
         self.currentIndex = currentIndex == 0 ? 0 : currentIndex - 1
     }


}






