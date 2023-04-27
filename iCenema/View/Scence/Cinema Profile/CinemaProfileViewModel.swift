//
//  CinemaProfileViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/03/2023.
//

import SwiftUI

class CinemaProfileViewModel: ProfileViewDelegate {
    
    var cinema: Cinema

    var dismissAction: (() -> Void) = { } 
    @Published var bookNow: ((_ movie: Movie) -> Void) = { _ in }
    @Published var showMore: ((_ movie: Movie) -> Void) = { _ in }
    
    init(cinema: Cinema) {
        self.cinema = cinema
    }
    
    
    public func followButtonTapped() {

    }
    
   
}
