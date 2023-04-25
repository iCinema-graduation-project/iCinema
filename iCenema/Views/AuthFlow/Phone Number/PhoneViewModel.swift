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
class PhoneViewModel: CancellableViewModel {
    
    @Published private(set) var isPhoneNumberValid: Bool = false
    
    private(set) var phoneNumber: String = "" {
        didSet {
            self.isPhoneNumberValid = self.checkPhoneNumberValidity(phoneNumber)
        }
    }
    
    var cancellableSet: Set<AnyCancellable> = []

    // MARK: - Delegate
    func didChanged(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
    
    // MARK: - Helper
    //
    private func checkPhoneNumberValidity(_ phoneNumber: String) -> Bool {
        
        let phoneRegEx = "(01)[0-9]{9}"
        let phonePredict = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        
        return phonePredict.evaluate(with: phoneNumber)
    }
    
    
    public func request(_ completion: @escaping (Result<Login, NetworkError>) -> Void) {
        
        let service = PhoneNumberService(phone: self.phoneNumber)
        service.request().sink { response in
            
            if let error = response.error {
                
                completion(.failure(error))
                
            } else if let value = response.value {
                
                completion(.success(value))
                
            } else {
                
                completion(.failure(.other))
                
            }
            
        }
        .store(in: &cancellableSet)
        
    }
    
}


