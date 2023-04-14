//
//  OTPViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/02/2023.
//

import UIKit
import Combine

class OTPViewController: ICinemaViewController {
    // MARK: - Views
    //
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = .otp.descriptionLabel
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
    
    private lazy var confirmButton = ICinemaButton(title: .otp.confirm, action: self.confirmButtonTapped)
    
    let activityIndicator = ActivityIndicator()
    
    // MARK: - Properties
    lazy var viewModel = OTPViewModel()
    private var cancellableSet: Set<AnyCancellable> = []
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.addTitleView(title: .otp.verification)
        self.addAndConfigureSubviews()
    }
    
    // MARK: - View Helper Methods
    //
    private func addAndConfigureSubviews(){
        addDescriptionLabel()
        addverificationCodeStackView()
        addVerificationCodeTextFields()
        addConfirmButton()
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.makeDescreptionLabel()
    }
    
    private func addverificationCodeStackView() {
        view.addSubview(verificationCodeStackView)
        verificationCodeStackView.fillXSuperViewConstraints(paddingLeft: .view.padding.left,
                                                            paddingRight: .view.padding.right)
        verificationCodeStackView.centerXInSuperview()
        verificationCodeStackView.makeConstraints(topAnchor: descriptionLabel.bottomAnchor,
                                                  padding: UIEdgeInsets(top: .view.padding.top,
                                                                        left: 0, bottom: 0, right: 0))
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
        confirmButton.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                      padding: UIEdgeInsets(top: 0, left: 0,
                                                            bottom: .view.padding.bottom, right: 0))
    }
    
    
    // MARK: - Actions
    //
    private func confirmButtonTapped() {
        if self.viewModel.otp.isEmpty {
            self.selectEmptyTextField()
            return
        }
        self.coordinator?.push()
//        self.networkRequest()
    }
    
    private func networkRequest() {
        view.addSubview(activityIndicator)
        activityIndicator.play()
        self.viewModel.request()
            .sink { [ unowned self ]  response in
                self.activityIndicator.stop()
                if let _ = response.error {
                   
                } else {
                    self.coordinator?.push()
                }
            }
            .store(in: &cancellableSet)
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

