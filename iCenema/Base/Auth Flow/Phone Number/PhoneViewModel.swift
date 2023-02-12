//
//  PhoneViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/02/2023.
//

import UIKit

// MARK: - PhoneViewModel Protocols
//
protocol PhoneViewModelInput {
    func didChange(phoneNumber: String)
}

protocol PhoneViewModelOutput {
    func onPhoneNumberChanged(completion: @escaping (Bool) -> Void )
}

protocol PhoneViewModelTypes {
    var inputs: PhoneViewModelInput { get }
    var output: PhoneViewModelOutput { get }
    var isPhoneNumberValid: Bool { get }
}

// MARK: - PhoneViewModel
//
class PhoneViewModel: PhoneViewModelTypes {
    var inputs: PhoneViewModelInput { self }
    var output: PhoneViewModelOutput { self }
    
    private var didPhoneNumberChanged: (_ isValid: Bool) -> Void = { _ in }

    private var phoneNumber: String = "" {
        didSet {
            self.isPhoneNumberValid = self.isValidPhoneNumber(phoneNumber)
        }
    }
    
    public var isPhoneNumberValid: Bool = false
   
    private func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        
        let phoneRegEx = "(01)[0-9]{9}"
        let phonePredict = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        
        return phonePredict.evaluate(with: phoneNumber)
    }
}

// MARK: - input bindind
//
extension PhoneViewModel: PhoneViewModelInput {
    func didChange(phoneNumber: String) {
        self.phoneNumber = phoneNumber
        self.didPhoneNumberChanged(isPhoneNumberValid)
    }
}

// MARK: - output binding
//
extension PhoneViewModel: PhoneViewModelOutput {
    func onPhoneNumberChanged(completion: @escaping (Bool) -> Void) {
        self.didPhoneNumberChanged = completion
    }
    
   
}


