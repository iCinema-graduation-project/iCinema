//
//  CategoriesService.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/04/2023.
//

import Foundation
import Combine
import NetworkLayer


protocol CategoriesFeatcher {
    func getCategories(_ completion: @escaping (Result<Categories, NetworkError>) -> Void)
}

class CategoriesService: APIRequest, CategoriesFeatcher {
    var cancellableSet: Set<AnyCancellable> = []
    
    typealias DecodableType = Categories
    
    var networkRequest: NetworkRequest = NetworkRequest(endpoint: "categories", method: .get)
    
    var cancelable: AnyCancellable = AnyCancellable({})
    
    func getCategories(_ completion: @escaping (Result<Categories, NetworkError>) -> Void) {
//        cancelable = self.request()
//            .sink { response in
//                if let value = response.value {
//                    completion(.success(value))
//                } else if let error = response.error {
//                    completion(.failure(error))
//                } else {
//                    completion(.failure(.other))
//                }
//            }
     }
}
