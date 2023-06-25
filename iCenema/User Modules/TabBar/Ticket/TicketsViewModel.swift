//
//  TicketsViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/06/2023.
//

import Foundation
import SwiftUI

class TicketsViewModel: ObservableObject {
    @Published var tickets: [Ticket] = []
    
    var service: NetworkLayer<TicketsModel> = .init(endpoint: "booking/new", method: .get)
}
