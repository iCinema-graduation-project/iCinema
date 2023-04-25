//
//  PhoneViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 31/01/2023.
//

import UIKit
import CountryPickerView
import SPAlert

class PhoneViewController:  ICinemaViewController {
    // MARK: - Views
    //
    private let descriptionLabel: UILabel = UILabel()
    
    private let TextFieldsStackView: UIStackView = UIStackView()
    
    private let countryView: ICinemaTextField = {
        let textfield = ICinemaTextField(placeholder: .phone.country)
        textfield.text = "."
        textfield.isEnabled = false
        textfield.setState(.normal, for: .disabled)
        textfield.setTextColor(.clear, for: .disabled)
        textfield.font = .textfeild
        return textfield
    }()
    
    private let countryPickerView: CountryPickerView = {
        let countryView = CountryPickerView()
        countryView.textColor = .iCinemaTextColor
        countryView.font = .title3
        countryView.showCountryNameInView = true
        countryView.setCountryByCode("EG")
        return countryView
    }()
    
    let phoneNumberTextField: ICinemaTextField = {
        let textfield = ICinemaTextField(placeholder: .phone.phoneNumber)
        textfield.keyboardType = .phonePad
        textfield.font = .textfeild
        return textfield
    }()
    
    private lazy var getCodeButton = ICinemaButton(title: .phone.getCode, action: self.getCodeButtonTapped)
    
    let activityIndicator = ActivityIndicator()
    
    // MARK: - Properites
    //
    var viewModel = PhoneViewModel()
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.addTitleView(title: .register)
        self.updateUI()
        
        self.bindViewModelOutput()
        self.bindViewModelInput()
        
        phoneNumberTextField.delegate = self
                
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.phoneNumberTextField.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.cancelAllRequests()
    }
    
    // MARK: - Update UI
    //
    private func updateUI() {
        addDescriptionLabel()
        addTextFieldsStackView()
        addCountryPickerView()
        addGetCodeButton()
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.text = .phone.descriptionLabel
        descriptionLabel.makeDescreptionLabel()
    }
    
    private func addTextFieldsStackView() {
        view.addSubview(TextFieldsStackView)
        TextFieldsStackView.axis = .vertical
        TextFieldsStackView.distribution = .fill
        TextFieldsStackView.spacing = .view.spacing
        TextFieldsStackView.centerXInSuperview()
        TextFieldsStackView.makeConstraints(topAnchor: descriptionLabel.bottomAnchor, padding: CGFloat.view.padding)
        TextFieldsStackView.addArrangedSubview(countryView)
        TextFieldsStackView.addArrangedSubview(phoneNumberTextField)
        TextFieldsStackView.arrangedSubviews.forEach {$0.widthConstraints(.view.width)}
    }
    
    private func addCountryPickerView() {
        view.addSubview(countryPickerView)
        countryPickerView.makeConstraints(leadingAnchor: countryView.leadingAnchor,
                                          centerYAnchor: countryView.centerYAnchor,
                                          padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        countryPickerView.hostViewController = self
        countryPickerView.isUserInteractionEnabled = false
    }
    
    private func addGetCodeButton(){
        view.addSubview(getCodeButton)
        getCodeButton.addToitsSuperView()
    }
    
    // MARK: - Actions
    //
    private func getCodeButtonTapped(){
        guard self.viewModel.isPhoneNumberValid else {
            let message = String.phone.errorMessage
            self.phoneNumberTextField.becomeFirstResponder()
            self.phoneNumberTextField.setState(.fail, with: message, for: .editing)
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
            case .success( let value ):
                print(value)
                self.coordinator?.push(userInfo: ["phone": self.viewModel.phoneNumber])
            case .failure(let failure):
                let error = NetworkError.getErrorMessage(from: failure)
                self.phoneNumberTextField.setState(.fail, with: error, for: .editing)
                self.phoneNumberTextField.setState(.fail, with: error, for: .normal)
             
            }
            
        }
        
    }
    
}


// MARK: - UITextFieldDelegate
//
extension PhoneViewController : UITextFieldDelegate {
    // limit the carachters count that text field can hold
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return prospectiveText.count <= 11
    }
}

// MARK: - Bind ViewModel Output
//
extension PhoneViewController {
    
    private func bindViewModelOutput() {
        viewModel.$isPhoneNumberValid.sink { isValid in
            if isValid {
                self.phoneNumberTextField.setState(.success, for: .editing)
                self.phoneNumberTextField.setState(.success, for: .normal)
                self.endEditing()
            }
        }
        .store(in: &viewModel.cancellableSet)
    }
    
}

// MARK: - Bind ViewModel Input
//
extension PhoneViewController {
    private func bindViewModelInput() {
        phoneNumberTextField.addTarget(self, action: #selector(self.phoneNumberTextFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    @objc private func phoneNumberTextFieldEditingChanged(_ sender: ICinemaTextField) {
        self.viewModel.didChanged(phoneNumber: sender.text!)
    }
}

