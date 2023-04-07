//
//  PhoneViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/02/2023.
//

import UIKit
import Combine

// MARK: - PhoneViewModel Protocols
//
protocol PhoneViewModelInput {
    func didChange(phoneNumber: String)
}

protocol PhoneViewModelOutput: APIRequest {
    var isPhoneNumberValid: Bool { get }
}

// MARK: - PhoneViewModel
//
class PhoneViewModel: PhoneViewModelOutput {
    
    @Published private(set) var isPhoneNumberValid: Bool = false
    
    typealias DecodableType = Countries
    var request: Request = Request(endpoint: "all_countries.php", method: .get, parameters: nil)


    // MARK: - Private Properties
    private(set) var phoneNumber: String = "" {
        didSet {
            self.isPhoneNumberValid = self.checkPhoneNumberValidity(phoneNumber)
        }
    }
    
    private func checkPhoneNumberValidity(_ phoneNumber: String) -> Bool {
        
        let phoneRegEx = "(01)[0-9]{9}"
        let phonePredict = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        
        return phonePredict.evaluate(with: phoneNumber)
    }
}


// MARK: - input binding
//
extension PhoneViewModel: PhoneViewModelInput {
    func didChange(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
}






