//
//  CinemaProfileViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/03/2023.
//

import SwiftUI

class CinemaProfileViewModel: ProfileViewDelegate {
    var dismissAction: (() -> Void) = { }
    
    @Published var bookNow: ((_ movie: Movie) -> Void) = { _ in }
    @Published var showMore: ((_ movie: Movie) -> Void) = { _ in }
    
    @Published var cinema: Cinema? = nil

  
    @Published var text = "ahmed"
    
    
    public func followButtonTapped() {

    }
    
   
}
