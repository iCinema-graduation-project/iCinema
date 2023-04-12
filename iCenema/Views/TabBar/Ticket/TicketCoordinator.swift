//
//  TicketCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit


final class TicketCoordinator: Coordinator {
    
    override init() {
        super.init()
        coordinators = [TicketViewController.self]
        push()
    }

}
