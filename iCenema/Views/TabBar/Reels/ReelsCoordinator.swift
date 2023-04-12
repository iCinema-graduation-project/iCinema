//
//  ReelsCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit


final class ReelsCoordinator: Coordinator {

    override init() {
        super.init()
        coordinators = [ReelsViewController.self]
        push()
    }

}
