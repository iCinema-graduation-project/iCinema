//
//  iCinemaTextField.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields


typealias iTextField = MDCOutlinedTextField

public enum TextFieldState {
    case success, fail, normal
}

extension MDCOutlinedTextField {
    public convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
        self.label.text = placeholder
    }
    
    public func setState(_ state: TextFieldState, with message: String = "", for controlState: MDCTextControlState = .normal) {
        
        var color: UIColor = .label
        switch state {
        case .success:
            color = .systemGreen
        case .fail:
            color = .systemRed
        case .normal:
            color = .label
        }
        
        setFloatingLabelColor(color, for: controlState)
        setOutlineColor(color, for: controlState)
        setLeadingAssistiveLabelColor(color, for: controlState)
        leadingAssistiveLabel.text = message
    }
}


