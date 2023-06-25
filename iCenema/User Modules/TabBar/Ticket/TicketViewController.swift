//
//  TicketViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import MakeConstraints

class TicketViewController: ICinemaViewController {
    var viewModel = TicketsViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.service.request { response in
            if let value = response.value {
                self.viewModel.tickets = value.data.data
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let ticketsView = TicketsView(view: self)
            .environmentObject(self.viewModel)
            .hostigView()
        
        view.addSubview(ticketsView)
        ticketsView.fillSuperviewConstraints()
        navigationItem.addTitleView(title: "Tickets")
    }
    

  

}
