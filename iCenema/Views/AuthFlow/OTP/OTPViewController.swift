//
//  OTPViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/02/2023.
//

import UIKit
import SPAlert

class OTPViewController: ICinemaViewController {
    // MARK: - Views
    //
    private let descriptionLabel: UILabel = UILabel()
    private let verificationCodeStackView: UIStackView = UIStackView()
    lazy var verificationCodeTextFields: [ICinemaTextField] = []
    private lazy var confirmButton = ICinemaButton(title: .otp.confirm, action: self.confirmButtonTapped)
    
    let activityIndicator = ActivityIndicator()
    
    // MARK: - Properties
    lazy var viewModel = OTPViewModel()
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.addTitleView(title: .otp.verification)
        self.updateUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.selectEmptyTextField()
    }
    
    // MARK: - Update UI
    //
    private func updateUI(){
        addDescriptionLabel()
        addVerificationCodeStackView()
        addVerificationCodeTextFields()
        addConfirmButton()
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.text = .otp.descriptionLabel
        descriptionLabel.makeDescreptionLabel()
    }
    
    private func addVerificationCodeStackView() {
        view.addSubview(verificationCodeStackView)
        verificationCodeStackView.axis = .horizontal
        verificationCodeStackView.distribution = .fillEqually
        verificationCodeStackView.spacing = 10
        verificationCodeStackView.fillXSuperViewConstraints(paddingLeft: .view.padding.left, paddingRight: .view.padding.right)
        verificationCodeStackView.centerXInSuperview()
        verificationCodeStackView.makeConstraints(topAnchor: descriptionLabel.bottomAnchor, padding: CGFloat.view.padding)
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
            textField.textContentType = .oneTimeCode
            textField.addTarget(self, action: #selector(self.textFieldsDidChanged(_:)), for: .editingChanged)
            textField.font = .textfeild
            if index != 0 {
                textField.isEnabled = false
            }
        }
    }
    
    private func addConfirmButton() {
        view.addSubview(confirmButton)
        confirmButton.addToitsSuperView()
    }
    
    
    // MARK: - Actions
    //
    private func confirmButtonTapped() {
        if self.viewModel.otp.isEmpty {
            self.selectEmptyTextField()
            return
        }
        self.networkRequest()
    }
    
    private func networkRequest() {
        view.addSubview(activityIndicator)
        activityIndicator.play()
        
        self.viewModel.request { result in
            self.activityIndicator.stop()
            
            switch result {
            case .success( _ ):
                self.coordinator?.push()
            case .failure(let failure):
                let error = NetworkError.getErrorMessage(from: failure)
                print(error)
                self.resetTextFields(with: .fail)

            }
        }
        
    }
    
    private func resetTextFields(with state: TextFieldState) {
        for field in self.verificationCodeTextFields {
            field.text = nil
            field.setState(state, for: .normal)
            field.setState(state, for: .disabled)
            if field.tag != 0 {
                field.isEnabled = false
            }
        }
        self.viewModel.reset()
    }
    
    @objc private func textFieldsDidChanged(_ textField: ICinemaTextField) {
        let text = textField.text ?? ""
        self.viewModel.textField(didChanged: text, at: textField.tag)
        
        if !text.isEmpty {
            self.selectNextTextFieldByTagOrEndEditing(textField)
        }
    }
    
    // MARK: - Helper Methods
    private func selectEmptyTextField() {
        for textField in self.verificationCodeTextFields {
            let text = textField.text ?? ""
            if text.isEmpty {
                textField.becomeFirstResponder()
                return
            }
        }
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textField = textField as? ICinemaTextField else { return }
        textField.setState(.success, for: .editing)
        textField.setState(.success, for: .normal)
    }

}

