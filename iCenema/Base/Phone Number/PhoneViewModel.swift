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
protocol PhoneViewModelOutput {
    func onPhoneNumberChanged(completion: @escaping (Bool) -> Void )
}

protocol PhoneViewModelTypes {
    var inputs: PhoneViewModelInput { get }
    var output: PhoneViewModelOutput { get }
}

class PhoneViewModel: PhoneViewModelTypes {
    var inputs: PhoneViewModelInput { self }
    var output: PhoneViewModelOutput { self }
    private var didPhoneNumberChanged: (_ isValid: Bool) -> Void = { _ in }
    
    init() {}
    
    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        
        let phoneRegEx = "(01)[0-9]{9}"
        let phonePredict = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        
        return phonePredict.evaluate(with: phoneNumber)
    }
}


extension PhoneViewModel: PhoneViewModelInput {
    
    func didChange(phoneNumber: String) {
        let isValidPhoneNumber = self.isValidPhoneNumber(phoneNumber)
        self.didPhoneNumberChanged(isValidPhoneNumber)
    }
    
}

extension PhoneViewModel: PhoneViewModelOutput {
    func onPhoneNumberChanged(completion: @escaping (Bool) -> Void) {
        self.didPhoneNumberChanged = completion
    }
    
    
}

