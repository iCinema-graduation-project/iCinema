//
//  NewUserViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 10/02/2023.
//

import Foundation
import Combine
import SwiftUI
import Alamofire
import NetworkLayer
import LocationManager

class EditUserProfileViewModel: ObservableObject {

    @Published var image: UIImage = .init()
    @Published var fullName: String = ""
    @Published var age: Int = 0
    @Published var gender: Gender = .none
    @Published var selectedCategories: [Category] = []
    
    lazy var service: NetworkLayer<EditUserProfile> = .init(endpoint: "update-account-data?_method=put", method: .put)
    var categoriesFeatcher: NetworkLayer = CategoriesFetcher()
    var profileFeatcher: NetworkLayer = ProfileFetcher()
    
    init() {
        
        profileFeatcher.request { response in
            print(response.value)
            if let value = response.value {
                self.fullName = value.user?.name ?? ""
                self.age = value.user?.age ?? 0
                self.gender = Gender(rawValue: value.user?.gender ?? "") ?? .none
                self.selectedCategories = value.user?.categories ?? []
            } else if let error = response.error {
                let errorMessage = NetworkError.getErrorMessage(from: error)
                SPAlert.showAlert(with: errorMessage)
            }else {
                SPAlert.showUnKnownError()
            }
        }
       
    }
    
    func updateProfile(_ completion: @escaping (Result<EditUserProfile, NetworkError>) -> Void) {
//        self.service.request()
//            .sink { response in
//                let str = String(decoding: response.data!, as: UTF8.self)
//                print(str)
//                if let value = response.value {
//                    completion(.success(value))
//                } else if let error = response.error {
//                    completion(.failure(error))
//                } else {
//
//                }
//            }
//            .store(in: &cancellableSet)
    }
 
    
    private func bindCategories() {
        service.networkRequest.update(parameters: [
            "dob": "28-6-2001",
            "lat": LocationManager.shared.latitude ?? 0.0,
            "lng": LocationManager.shared.longitude ?? 0.0,
            "address": "Mansoura - Dikernes",
        ])
        
//        $fullName.sink { self.service.networkRequest.update(parameters:["name": $0 ]) }.store(in: &cancellableSet)
//        $gender.sink { self.service.networkRequest.update(parameters: ["gender": $0.rawValue]) }.store(in: &cancellableSet)
//        $age.sink { self.service.networkRequest.update(parameters: ["age": $0]) }.store(in: &cancellableSet)
//        $selectedCategories.sink { self.service.networkRequest.update(parameters: ["categories": $0.map { $0.id } ]) }.store(in: &cancellableSet)
//
//        $image.sink { image in
//
//
//        }.store(in: &cancellableSet)
        
    }
  
}
    
 


