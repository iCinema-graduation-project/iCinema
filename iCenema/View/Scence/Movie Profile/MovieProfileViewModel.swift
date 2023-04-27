//
//  MovieProfileViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 11/04/2023.
//

import SwiftUI

class MovieProfileViewModel: ProfileViewDelegate {
    
    var movie: Movie

    var dismissAction: (() -> Void) = { }
    @Published var bookNow: ((_ movie: Movie) -> Void) = { _ in }
    @Published var showMore: ((_ movie: Movie) -> Void) = { _ in }
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    

    
   
}
