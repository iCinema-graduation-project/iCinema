//
//  OTPViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/02/2023.
//

import UIKit

// MARK: - view model protocols
protocol OTPViewModelType {
    var input: OTPViewModelInput { get }
    var output: OTPViewModelOutput { get }
    
}

protocol OTPViewModelInput {
    func textField(didChanged text: String, at index: Int)
}

protocol OTPViewModelOutput {
    func confirm(completion: @escaping (_ isOTPEmpty: Bool, _ isOTPValid: Bool) -> Void )
}

// MARK: - View Model
class OTPViewModel: OTPViewModelType {
    var input: OTPViewModelInput { self }
    var output: OTPViewModelOutput { self }
    
    private(set) var otp = OTPString(count: 5)

}

// MARK: - View Model input
extension OTPViewModel: OTPViewModelInput {
    func textField(didChanged text: String, at index: Int) {
        let textIsNotEmpty = !text.isEmpty
        if textIsNotEmpty {
            self.otp.add(charachter: text, at: index)
        }else{
            self.otp.removeCharachter(at: index)
        }
        print(self.otp.code)

    }
}

// MARK: - View Model output
extension OTPViewModel: OTPViewModelOutput {
    func confirm(completion: @escaping (_ isOTPEmpty: Bool, _ isOTPValid: Bool) -> Void ) {
        
        let isOTPEmpty = self.otp.isEmpty
        
        if isOTPEmpty  {
            completion(isOTPEmpty, false)
            
        } else {
            /*
             otpNetworkRequest(otp: self.otp.code) { isOTPValid in
                completion(isOTPEmpty, isOTPValid)
             }
             */
            
            completion(isOTPEmpty, true)
        }
    }
}

