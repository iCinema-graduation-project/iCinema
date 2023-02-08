//
//  OTPViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/02/2023.
//

import UIKit
import SwiftUI

class OTPViewController: ICinemaViewController {
    // MARK: - Views
    //
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = LanguageManager.otpDescriptionLabel
        label.tintColor = ColorManager.textColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.widthConstraints(SizeManager.textWidth)
        return label
    }()
    
    private let verificationCodeStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 10
        return stackview
    }()
    
    lazy var verificationCodeTextFields: [ICinemaTextField] = []
    
    private let confirmButton = ICinemaButton(title: LanguageManager.confirm)
    
    
    // MARK: - Properties
    lazy var viewModel = OTPViewModel(view: self)
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavigationTitleView(title: LanguageManager.verification)
        self.addAndConfigureSubviews()
    }
    
    // MARK: - Helper Functions
    //
    private func addAndConfigureSubviews(){
        addDescriptionLabel()
        addverificationCodeStackView()
        addVerificationCodeTextFields()
        addConfirmButton()
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.centerXInSuperview()
        descriptionLabel.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                         padding: UIEdgeInsets(top: SizeManager.viewPadding, left: 0, bottom: 0, right: 0))
    }
    
    private func addverificationCodeStackView() {
        view.addSubview(verificationCodeStackView)
        verificationCodeStackView.widthConstraints(SizeManager.textWidth)
        verificationCodeStackView.centerXInSuperview()
        verificationCodeStackView.makeConstraints(topAnchor: descriptionLabel.bottomAnchor, padding: UIEdgeInsets(top: SizeManager.viewPadding, left: 0, bottom: 0, right: 0))
    }
    
    private func addVerificationCodeTextFields() {
        for index in 0...4{
            let textField = ICinemaTextField(placeholder: "")
            textField.delegate = self
            verificationCodeStackView.addArrangedSubview(textField)
            self.verificationCodeTextFields.append(textField)
            textField.tag = index
            textField.textAlignment = .center
            textField.keyboardType = .numberPad
            textField.addTarget(self, action: #selector(self.textFieldsDidChanged(_:)), for: .editingChanged)
        }
    }
    
    private func addConfirmButton() {
        view.addSubview(confirmButton)
        confirmButton.centerXInSuperview()
        confirmButton.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: SizeManager.viewPadding, right: 0))
        confirmButton.addTarget(self, action: #selector(self.confirmButtonTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - Actions
    //
    @objc private func confirmButtonTapped(_ sender: ICinemaButton) {
        sender.addAnimate {
            self.viewModel.didConfirmButtonPressed(sender)
        }
    }
    
    @objc private func textFieldsDidChanged(_ textField: ICinemaTextField) {
        viewModel.textField(didChanged: textField)
    }
    
}

// MARK: - UITextFieldDelegate
//
extension OTPViewController : UITextFieldDelegate {
    // limit the count of charecters in text field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return prospectiveText.count <= 1
    }
    

}

