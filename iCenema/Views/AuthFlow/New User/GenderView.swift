//
//  GenderView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 14/04/2023.
//

import UIKit


class GenderView {
    var gender: Gender = .female
   
    public lazy var view: ICinemaTextField = {
        let textfield = ICinemaTextField(placeholder: .newUser.gender)
        textfield.text = "."
        textfield.isEnabled = false
        textfield.setState(.normal, for: .disabled)
        textfield.setTextColor(.clear, for: .disabled)
        textfield.font = .textfeild
        
        return textfield
    }()
    
    private lazy var femaleButton: RadioButton = {
        let button = RadioButton(onSelected: { isSelected in
            if isSelected {
                self.maleButton.isSelected = false
                self.gender = .female
                self.maleButton.isUserInteractionEnabled = true
                self.femaleButton.isUserInteractionEnabled = false
            }
        })
        button.setTitle(.newUser.female, for: .normal)
        button.titleLabel?.font = .footnote
        return button
    }()
    
    private lazy var maleButton: RadioButton = {
        let button = RadioButton { isSelected in
            if isSelected {
                self.femaleButton.isSelected = false
                self.gender = .male
                self.maleButton.isUserInteractionEnabled = false
                self.femaleButton.isUserInteractionEnabled = true
            }
        }
        button.setTitle(.newUser.male, for: .normal)
        button.titleLabel?.font = .footnote
        return button
    }()
    
    private lazy var genderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [femaleButton, maleButton])
        stackView.axis = .horizontal
        stackView.spacing = .view.spacing
        stackView.arrangedSubviews.forEach { $0.tintColor = .iCinemaTextColor }
        return stackView
    }()
    
    let presenterView: UIView
    init(presenterView: UIView) {
        self.presenterView = presenterView
    }
    
   
    func updateGenders() {
        presenterView.addSubview(genderStackView)
        genderStackView.makeConstraints(centerXAnchor: view.centerXAnchor, centerYAnchor: view.centerYAnchor)
   
    }
}
