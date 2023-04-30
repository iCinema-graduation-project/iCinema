//
//  NewUserViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 10/02/2023.
//

import Foundation
import Combine
import UIKit.UIImage
import Alamofire
import NetworkLayer
import LocationManager
import SwiftyJSON


class EditUserProfileViewModel: ObservableObject {
    // MARK: - Publishers
    @Published var image: UIImage = .init()
    @Published var fullName: String = ""
    @Published var age: Int = 0
    @Published var gender: Gender = .none
    @Published var selectedCategories: [Category] = []
    @Published var profile: ProfileModel? = nil
    @Published var categories: [CategoriesData] = []
    
    // MARK: - Services
    var service: NetworkLayer<EditUserProfile> = .init(endpoint: "update-account-data?_method=put", method: .post)
    var categoriesFeatcher: NetworkLayer = CategoriesFetcher()
    var profileFeatcher: NetworkLayer = ProfileFetcher()
    
    init() {
        self.bindPublishersAndUpdateServiceParameters()
        self.service.networkRequest.update(headers: ["Content-Type": "multipart/form-data"])
    }

    // MARK: - Helpers
    /// bind and updates service parameters
    private func bindPublishersAndUpdateServiceParameters() {
        service.networkRequest.update(parameters: [
            "dob": "28-6-2001",
            "lat": LocationManager.shared.latitude ?? 0.0,
            "lng": LocationManager.shared.longitude ?? 0.0,
            "address": "\(LocationManager.shared.administrativeArea ?? "") - \(LocationManager.shared.locality ?? "")",
        ])
        
        $fullName.sink { self.service.networkRequest.update(parameters:["name": $0 ]) }.store(in: &service.cancellableSet)
        
        $gender.sink { self.service.networkRequest.update(parameters: ["gender": $0.rawValue]) }.store(in: &service.cancellableSet)
        
        $age.sink { self.service.networkRequest.update(parameters: ["age": $0]) }.store(in: &service.cancellableSet)
        
        $selectedCategories.sink { self.service.networkRequest.update(parameters: ["categories": $0.map { $0.id } ]) }.store(in: &service.cancellableSet)
        
    }
      
}
    
 
