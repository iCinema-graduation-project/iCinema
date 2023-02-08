//
//  OTPViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/02/2023.
//

import UIKit

protocol OTPViewModelType {
    func textField(didChanged textField: ICinemaTextField)
    func didConfirmButtonPressed(_ sender: ICinemaButton)
}

class OTPViewModel: OTPViewModelType {
    
    private let view: OTPViewController
    private var otp = OTPString()
    
    init(view: OTPViewController){
        self.view = view
    }
    
    func textField(didChanged textField: ICinemaTextField) {
        let text = textField.text ?? ""
        let textIsNotEmpty = !text.isEmpty
        if textIsNotEmpty {
            self.otp.add(charachter: text, at: textField.tag)
            self.view.selectNextTextFieldByTagOrEndEditing(textField)
        }else{
            self.otp.removeCharachter(at: textField.tag)
        }
        print(self.otp.code)
    }
    
    func didConfirmButtonPressed(_ sender: ICinemaButton) {
        
        let verificationCodeIsNotCompleted = !otp.isValid()
        if verificationCodeIsNotCompleted {
            selectEmptyTextField()
        } else {
            // should send network request to check the code then if is valid push to next coordinator
            self.view.coordinator?.push()
        }
        
    }
    
    private func selectEmptyTextField() {
        for textField in view.verificationCodeTextFields {
            let text = textField.text ?? ""
            if text.isEmpty {
                textField.becomeFirstResponder()
                return
            }
        }
    }
        
}


struct OTPString {
    var code: String = ""
    
    mutating func add(charachter: String, at index: Int) {
        let charachter = Character(charachter)
        let stringIndex = code.index(code.startIndex, offsetBy: index)
        code.insert(charachter, at: stringIndex)
    }
    
    mutating func removeCharachter(at index: Int){
        let stringIndex = code.index(code.startIndex, offsetBy: index)
        code.remove(at: stringIndex)
    }
    
    func isValid() -> Bool {
        return code.count == 5
    }
}

