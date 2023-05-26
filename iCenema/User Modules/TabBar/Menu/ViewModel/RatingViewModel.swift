//
//  RatingViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/05/2023.
//

import Combine

class RatingViewModel: ObservableObject {
    @Published var rate: Int = 1
    @Published var title: String = ""
    @Published var review: String = ""
}
