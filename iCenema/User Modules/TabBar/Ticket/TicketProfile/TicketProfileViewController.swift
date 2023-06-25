//
//  TicketProfileViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/06/2023.
//

import UIKit
import MakeConstraints
import SwiftUI

class TicketProfileViewController: ICinemaViewController {
    
    var viewModel = TicketProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.dismissAction = { self.dismiss() }
        
        let ticketsProfileView = TicketProfileView()
            .environmentObject(self.viewModel)
            .hostigView()
        
        view.addSubview(ticketsProfileView)
        ticketsProfileView.fillSuperviewConstraints()
    }
    
    public func inject(with ticket: Ticket) {
        withAnimation {
            viewModel.ticket = ticket
        }
    }
}
