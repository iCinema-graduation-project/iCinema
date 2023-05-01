//
//  HomeViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/05/2023.
//

import Foundation


class HomeViewModel: ObservableObject {
    var service: NetworkLayer<HomeModel> = .init(endpoint: "home", method: .get)
    
}
