//
//  CinemaDateViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/03/2023.
//

import SwiftUI

class CinemaDateViewModel: ObservableObject {
    @Published var dates: [BookingDate] = []
    
    var service: NetworkLayer<BookingDetailModel> = .init(endpoint: "booking/data", method: .get)
    
    public func updateParamenter(with movieID: Int) {
        self.service.networkRequest.update(parameters: ["movie_id": movieID])
    }
    
    public func inject(with dates: [BookingDate]) {
        self.dates = dates
    }
    
}
