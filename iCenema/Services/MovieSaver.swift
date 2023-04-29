//
//  MovieSaver.swift
//  iCinema
//
//  Created by Ahmed Yamany on 29/04/2023.
//

import Foundation
import Alamofire

class MovieSaver: NetworkLayer<SaveMovieModel> {
    
    init() {
        super.init(endpoint: "movies/save-and-unsave", method: .post)
    }
    
    public func update(id: Int) {
        self.networkRequest.update(parameters: ["id": id])
    }
}
