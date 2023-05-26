//
//  ReelsCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import Coordinator

final class ReelsCoordinator: Coordinator {

    override init() {
        super.init()
        setViewControllers([ReelsViewController.self])
    }

}
