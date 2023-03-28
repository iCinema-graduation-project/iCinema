//
//  BookingCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/03/2023.
//

import UIKit


final class BookingCoordinator: Coordinator {
    var currentIndex: Int = -1
    var navigationController: UINavigationController = .init(nibName: nil, bundle: nil)
    var coordinators: [ViewController.Type] = [CinemaDateViewController.self, SelectHallViewController.self, CinemaChairsViewController.self]
    
    init() {
        push()
    }

}
