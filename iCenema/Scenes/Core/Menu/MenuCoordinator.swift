//
//  MenuCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit


final class MenuCoordinator: Coordinator {
    var currentIndex: Int = -1
    var navigationController: UINavigationController = .init(nibName: nil, bundle: nil)
    var coordinators: [ViewController.Type] = [MenuViewController.self]
    
    init() {
        push()
    }

}
