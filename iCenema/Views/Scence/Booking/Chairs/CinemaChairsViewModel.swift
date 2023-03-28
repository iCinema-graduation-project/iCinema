//
//  CinemaChairsViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/03/2023.
//

import SwiftUI

class CinemaChairsViewModel: ObservableObject {
    @Published var buttonAction: (() -> Void)? = nil
}
