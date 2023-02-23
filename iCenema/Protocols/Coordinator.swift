//
//  Coordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/02/2023.
//

import UIKit
import Foundation


class ViewController: UIViewController{
    // the coordinator is responsible for managing navigation between view controllers.
    var coordinator: Coordinator?
    var coordinatorType: CoordinatorType = .navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    // used to notify the coordinator when the view controller is popped from the navigation stack.
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            self.coordinator?.pop()
        }
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        if coordinatorType == .segue {
            self.coordinator?.pop()
        }
    }
}

enum CoordinatorType {
    case navigation
    case segue
}

// defines the expected behavior of coordinators,
// including managing a navigation controller and managing a stack of view controllers.
@objc protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var coordinators: [ViewController.Type] { get set }
}

fileprivate struct currentIndexHolder {
    static var currentIndex = -1
}

extension Coordinator {
    var currentIndex: Int {
        get {
            return currentIndexHolder.currentIndex
        }
        set {
            currentIndexHolder.currentIndex = newValue
        }
    }

    func push() {
        increaseCurrentIndex()
        let currentCoordinator = self.coordinators[currentIndex].init()
        currentCoordinator.coordinator = self
        if currentCoordinator.coordinatorType == .navigation {
            navigationController.pushViewController(currentCoordinator, animated: true)
        } else {
            navigationController.viewControllers.last?.present(currentCoordinator, animated: true)
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




