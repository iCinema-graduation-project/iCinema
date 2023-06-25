//
//  TicketProfileViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/06/2023.
//

import Foundation

class TicketProfileViewModel: ProfileViewDelegate, ObservableObject {
    var dismissAction: (() -> Void) = { }
    
    @Published var ticket: Ticket! = nil
    
}
