//
//  TicketViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit

class TicketViewController: ICinemaViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let ticketsView = TicketsView().hostigView()
        
        view.addSubview(ticketsView)
        
        ticketsView.fillSuperviewConstraints()
        
        navigationItem.addTitleView(title: "Tickets")
    }
    

  

}
