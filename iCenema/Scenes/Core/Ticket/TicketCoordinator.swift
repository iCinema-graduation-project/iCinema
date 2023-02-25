//
//  TicketCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit


final class TicketCoordinator: Coordinator {
    var currentIndex: Int = -1
    var navigationController: UINavigationController = .init(nibName: nil, bundle: nil)
    var coordinators: [ViewController.Type] = [TicketViewController.self]
    
    init() {
        push()
    }

}
