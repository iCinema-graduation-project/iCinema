//
//  PhoneViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 31/01/2023.
//

import UIKit
import CountryPickerView
import Combine

class PhoneViewController:  ICinemaViewController {
    // MARK: - Views
    //
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = .phone.descriptionLabel
        return label
    }()
    
    /// Input Text Fields
    private let TextFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = .view.spacing
        return stackView
    }()
    
    /// Select Country
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
    
    /// button
    private lazy var getCodeButton = ICinemaButton(title: .phone.getCode, action: self.getCodeButtonTapped)
    
    let activityIndicator = ActivityIndicator()
    
    // MARK: - Properites
    //
    let viewModel = PhoneViewModel()
    private var cancellableSet: Set<AnyCancellable> = []

    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.addTitleView(title: .register)
        addAndConfigurSubViews()
  
        self.bindViewModelOutput()
        self.bindViewModelInput()

        phoneNumberTextField.delegate = self
//        viewModel.
    }
    
    // MARK: - Update UI
    //
    private func addAndConfigurSubViews() {
        addDescriptionLabel()
        addTextFieldsStackView()
        addCountryPickerView()
        addGetCodeButton()
    }

    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.makeDescreptionLabel()

    }
    
    private func addTextFieldsStackView() {
        view.addSubview(TextFieldsStackView)
        TextFieldsStackView.centerXInSuperview()
        TextFieldsStackView.makeConstraints(topAnchor: descriptionLabel.bottomAnchor,
                                            padding: CGFloat.view.padding)
    
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
    }

    private func addGetCodeButton(){
        view.addSubview(getCodeButton)
        getCodeButton.centerXInSuperview()
        getCodeButton.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                      padding: UIEdgeInsets(top: 0, left: 0,
                                                            bottom: .view.padding.bottom, right: 0))
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
        self.coordinator?.push()

//        self.networkRequest()
    }
    
    private func networkRequest() {
        view.addSubview(activityIndicator)
        activityIndicator.play()
        self.viewModel.request()
            .sink { [ unowned self ] response in
                self.activityIndicator.stop()
                if let error = response.error {
                    let errorMessage = viewModel.getErrorMessage(from: error)
                    self.phoneNumberTextField.setState(.fail, with: errorMessage, for: .editing)
                    self.phoneNumberTextField.setState(.fail, with: errorMessage, for: .normal)
                }else {
                    self.coordinator?.push()
                }
            }
            .store(in: &cancellableSet)
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
        .store(in: &cancellableSet)
    }
    
}

// MARK: - Bind ViewModel Input
//
extension PhoneViewController {
    private func bindViewModelInput() {
        phoneNumberTextField.addTarget(self, action: #selector(self.phoneNumberTextFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    @objc private func phoneNumberTextFieldEditingChanged(_ sender: ICinemaTextField) {
        self.viewModel.didChange(phoneNumber: sender.text!)
    }
}

