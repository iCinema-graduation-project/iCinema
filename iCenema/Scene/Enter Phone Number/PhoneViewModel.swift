//
//  PhoneViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/02/2023.
//

import UIKit


protocol PhoneViewModelInput {
    func didChange(phoneNumber: String)
}

protocol PhoneViewModelTypes {
    var inputs: PhoneViewModelInput { get }
}

class PhoneViewModel: PhoneViewModelTypes {
    var inputs: PhoneViewModelInput { self }
    
    private var onPhoneNumberChanged: (_ isValid: Bool) -> Void = { _ in }
    
    init(onPhoneNumberChanged: @escaping (_ isValid: Bool) -> Void) {
        self.onPhoneNumberChanged = onPhoneNumberChanged
    }
    
    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        
        let phoneRegEx = "(01)[0-9]{9}"
        let phonePredict = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        
        return phonePredict.evaluate(with: phoneNumber)
    }
}


extension PhoneViewModel : PhoneViewModelInput {
    
    func didChange(phoneNumber: String) {
        let isValidPhoneNumber = self.isValidPhoneNumber(phoneNumber)
        self.onPhoneNumberChanged(isValidPhoneNumber)
    }
    
}


