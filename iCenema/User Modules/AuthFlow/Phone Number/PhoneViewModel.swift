//
//  PhoneViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/02/2023.
//

import UIKit
import Combine
import NetworkLayer
import Alamofire


// MARK: - PhoneViewModel
//
class PhoneViewModel {
    
    @Published private(set) var isPhoneNumberValid: Bool = false
    
    @Published var phoneNumber: String = ""    
    
    var service: NetworkLayer<Login> = .init(endpoint: "login", method: .post)

    init() {
        $phoneNumber.sink {
            self.isPhoneNumberValid = self.checkPhoneNumberValidity($0)
            self.service.networkRequest.update(parameters: ["phone": $0])
        }.store(in: &service.cancellableSet)
        self.service.networkRequest.update(parameters: ["country_code": "20"])
    }
    
    // MARK: - Helper
    //
    private func checkPhoneNumberValidity(_ phoneNumber: String) -> Bool {
        
        let phoneRegEx = "(01)[0-9]{9}"
        let phonePredict = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        
        return phonePredict.evaluate(with: phoneNumber)
    }
    
}


