//
//  MenuCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit


final class MenuCoordinator: Coordinator {

    override init() {
        super.init()
        coordinators = [MenuViewController.self]
        push()
    }

}
