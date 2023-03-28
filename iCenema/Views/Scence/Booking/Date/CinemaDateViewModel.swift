//
//  CinemaDateViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/03/2023.
//

import SwiftUI

class CinemaDateViewModel: ObservableObject {
    @Published var buttonAction: (() -> Void) = {}
}
