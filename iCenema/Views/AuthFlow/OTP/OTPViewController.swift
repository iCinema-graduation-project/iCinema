//
//  OTPViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/02/2023.
//

import UIKit


class OTPViewController: ICinemaViewController {
    // MARK: - Views
    //
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = .otpDescriptionLabel
        label.textColor = .iCinemaTextColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.widthConstraints(.view.width)
        label.font = .textfeild
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
    
    private lazy var confirmButton = ICinemaButton(title: .confirm, action: self.confirmButtonTapped)
    
    
    // MARK: - Properties
    lazy var viewModel: OTPViewModelType = OTPViewModel()
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.addTitleView(title: .verification)
        self.addAndConfigureSubviews()
    }
    
    // MARK: - View Helper Functions
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
                                         padding: UIEdgeInsets(top: .view.padding, left: 0, bottom: 0, right: 0))
    }
    
    private func addverificationCodeStackView() {
        view.addSubview(verificationCodeStackView)
        verificationCodeStackView.widthConstraints(.view.width)
        verificationCodeStackView.centerXInSuperview()
        verificationCodeStackView.makeConstraints(topAnchor: descriptionLabel.bottomAnchor, padding: UIEdgeInsets(top: .view.padding, left: 0, bottom: 0, right: 0))
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
            textField.font = .callout
            if index != 0 {
                textField.isEnabled = false
            }
        }
    }
    
    private func addConfirmButton() {
        view.addSubview(confirmButton)
        confirmButton.centerXInSuperview()
        confirmButton.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: .view.padding, right: 0))
    }
    
//    @available warning
    
    // MARK: - Actions
    //
    private func confirmButtonTapped() {
        self.viewModel.output.confirm { isOTPEmpty, isOTPValid in
            if isOTPEmpty {
                self.selectEmptyTextField()
            } else {
                if isOTPValid {
                    self.coordinator?.push()
                } else {
                    for textfield in self.verificationCodeTextFields{
                        textfield.text = ""
                        textfield.setState(.fail, for: .normal)
                        // do not forget to show alert with error message
                        #warning("do not forget to show alert with error message")
                    }
                }
            }
        }
    
    }
    
    @objc private func textFieldsDidChanged(_ textField: ICinemaTextField) {
        let text = textField.text ?? ""

        self.viewModel.input.textField(didChanged: text, at: textField.tag)
        
        if !text.isEmpty {
            self.selectNextTextFieldByTagOrEndEditing(textField)
        }
    }
    
    // MARK: - Helper Functions
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

