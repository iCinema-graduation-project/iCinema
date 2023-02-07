//
//  Coordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/02/2023.
//

import UIKit

class ViewController: UIViewController{
    // the coordinator is responsible for managing navigation between view controllers.
    var coordinator: Coordinator?
    
    // used to notify the coordinator when the view controller is popped from the navigation stack.
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            self.coordinator?.pop()
        }
    }
}

// defines the expected behavior of coordinators,
// including managing a navigation controller and managing a stack of view controllers.
protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var coordinators: [ViewController.Type] { get set }
    func push()
    func pop()
}
