//
//  NotificationCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import Coordinator

final class NotificationCoordinator: Coordinator {
 
    override init() {
        super.init()
        setViewControllers([NotificationViewController.self])
    }

}
