//
//  SavedViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 02/05/2023.
//

import Foundation

class SavedViewModel {
    var service: NetworkLayer<SavedModel> = .init(endpoint: "movies/saved", method: .get)
}
