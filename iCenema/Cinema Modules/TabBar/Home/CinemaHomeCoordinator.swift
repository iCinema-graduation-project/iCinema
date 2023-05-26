//
//  CinemaHomeCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/05/2023.
//

import UIKit
import Coordinator

class CinemaHomeCoordinator: Coordinator {
    
    override init() {
        super.init()
        
        setViewControllers([CinemaHomeViewController.self])
    }
}
