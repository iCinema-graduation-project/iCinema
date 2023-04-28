//
//  CategoriesService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/04/2023.
//

import Foundation
import NetworkLayer


class CategoriesFetcher: NetworkLayer<Categories> {
  
    init() {
        super.init(endpoint: "categories", method: .get)
    }
    
}
