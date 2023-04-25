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

class EditUserProfileViewModel: CancellableViewModel, ObservableObject {
    @Published var image: UIImage = .init() {
        didSet {
           imagedata = convertImageToBase64(image: image)
        }
    }
    @Published var fullName: String = ""
    @Published var age: Int = 0
    @Published var gender: Gender = .none
    @Published var selectedCategories: [Category] = []
    
    var cancellableSet: Set<AnyCancellable> = []
    lazy var service = EditUserProfileService(parameters: [
        "name": self.fullName,
        "dob": "18-5-2001",
        "gender": self.gender.rawValue,
        "lat": LocationManager.shared.latitude as Any,
        "lng": LocationManager.shared.longitude as Any,
        "address": "Mansoura - aga",
        "image": imagedata as Any,
        "categories": [8, 4]
    ])
    
    
    lazy var imagedata: String? = convertImageToBase64(image: UIImage(named: "profile")!)
    
    
    var categoriesFeatcher: CategoriesFeatcher = CategoriesService()
    
    func updateProfile(_ completion: @escaping (Result<EditUserProfile, NetworkError>) -> Void) {
        print(imagedata)
        self.service.request()
            .sink { response in
//                let str = String(decoding: response.data!, as: UTF8.self)
//                print(str)
                if let value = response.value {
                    completion(.success(value))
                } else if let error = response.error {
                    completion(.failure(error))
                } else {
                    
                }
            }
            .store(in: &cancellableSet)
    }
 
    func convertImageToBase64(image: UIImage) -> String? {
        let imageData = image.pngData()
        return imageData?.base64EncodedString(options:
                                                Data.Base64EncodingOptions.lineLength64Characters)
    }
}
    
 


