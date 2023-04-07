//
//  PhoneViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/02/2023.
//

import UIKit
import Combine


// MARK: - PhoneViewModel
//
class PhoneViewModel: APIRequest {
    
    @Published private(set) var isPhoneNumberValid: Bool = false
    
    typealias DecodableType = Countries
    var networkRequest: Request = Request(endpoint: "all_countries.php", method: .get, parameters: nil)


    func didChange(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
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
