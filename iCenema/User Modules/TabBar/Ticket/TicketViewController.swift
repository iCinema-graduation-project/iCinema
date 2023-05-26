//
//  TicketViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import MakeConstraints

class TicketViewController: ICinemaViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        TabBarViewModel.shared.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let ticketsView = TicketsView().hostigView()
        
        view.addSubview(ticketsView)
        
        ticketsView.fillSuperviewConstraints()
        
        navigationItem.addTitleView(title: "Tickets")
    }
    

  

}
