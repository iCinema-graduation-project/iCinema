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
    @Published var profile: Profile? = nil
    @Published var categories: [CategoriesData] = []
    
    // MARK: - Services
    var service: NetworkLayer<EditUserProfile> = .init(endpoint: "update-account-data?_method=put", method: .put)
    var categoriesFeatcher: NetworkLayer = CategoriesFetcher()
    var profileFeatcher: NetworkLayer = ProfileFetcher()
    
    init() {
        self.bindPublishersAndUpdateServiceParameters()
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
        
        $image.sink { image in
            guard let imageDate = image.jpegData(compressionQuality: 1) else { return }
            let randomKey = UUID().uuidString
            let bodyBoundary = "--------------------------\(randomKey)"

            self.service.networkRequest.update(headers: ["Content-Type": "multipart/form-data; boundary=\(bodyBoundary)"])
            let data = self.createRequestBody(imageData: imageDate, boundary: bodyBoundary, attachmentKey: "profilePicture", fileName: "\(randomKey).jpg")
//            self.service.networkRequest.update(parameters: ["image": data ])
            
        }.store(in: &service.cancellableSet)
        
    }
    
    func createRequestBody(imageData: Data, boundary: String, attachmentKey: String, fileName: String) -> Data{
        let lineBreak = "\r\n"
        var requestBody = Data()

        requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
        requestBody.append("Content-Disposition: form-data; name=\"\(attachmentKey)\"; filename=\"\(fileName)\"\(lineBreak)" .data(using: .utf8)!)
        requestBody.append("Content-Type: image/jpeg \(lineBreak + lineBreak)" .data(using: .utf8)!) // you can change the type accordingly if you want to
        requestBody.append(imageData)
        requestBody.append("\(lineBreak)--\(boundary)--\(lineBreak)" .data(using: .utf8)!)

        return requestBody
    }
    
    
    
  
}
    
 


