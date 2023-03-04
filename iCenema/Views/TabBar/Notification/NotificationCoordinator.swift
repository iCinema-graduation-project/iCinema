//
//  NotificationCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit


final class NotificationCoordinator: Coordinator {
    var currentIndex: Int = -1
    var navigationController: UINavigationController = .init(nibName: nil, bundle: nil)
    var coordinators: [ViewController.Type] = [NotificationViewController.self]
    
    init() {
        push()
    }

}
