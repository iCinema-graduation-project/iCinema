//
//  SelectHallViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/03/2023.
//

import SwiftUI

class SelectHallViewModel: ObservableObject {
    @Published var buttonAction: (() -> Void)? = nil
}
