//
//  Booking.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/05/2023.
//

import Coordinator
import Foundation

struct Booking {
    static var shared = Booking()
    
    var homeCoordinator: Coordinator? = nil
    
    public func startBooking(_ movieID: Int) {
        TabBarViewModel.shared.selectedTabIndex = 2
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {

            homeCoordinator?.push(userInfo: ["movieID": movieID])
        })
        
    }

}
