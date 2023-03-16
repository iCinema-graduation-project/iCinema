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
        label.text = .phoneDescriptionLabel
        label.tintColor = .iCinemaTextColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.widthConstraints(.view.width)
        label.font = .title3
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
        let textfield = ICinemaTextField(placeholder: .country)
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
        let textfield = ICinemaTextField(placeholder: .phoneNumber)
        textfield.keyboardType = .phonePad
        textfield.font = .textfeild
        return textfield
    }()
    
    /// button
    private lazy var getCodeButton = ICinemaButton(title: .getCode, action: self.getCodeButtonTapped)
    
    
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
    }
    
    // MARK: - Update UI Methods
    //
    private func addAndConfigurSubViews() {
        addDescriptionLabel()
        addTextFieldsStackView()
        addCountryPickerView()
        addGetCodeButton()
    }

    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.centerXInSuperview()
        descriptionLabel.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                         padding: UIEdgeInsets(top: .view.padding, left: 0, bottom: 0, right: 0))
    }
    
    private func addTextFieldsStackView() {
        view.addSubview(TextFieldsStackView)
        TextFieldsStackView.centerXInSuperview()
        TextFieldsStackView.makeConstraints(topAnchor: descriptionLabel.bottomAnchor,
                                            padding: UIEdgeInsets(top: .view.padding, left: 0, bottom: 0, right: 0))
    
        TextFieldsStackView.addArrangedSubview(countryView)
        TextFieldsStackView.addArrangedSubview(phoneNumberTextField)
        TextFieldsStackView.arrangedSubviews.forEach {$0.widthConstraints(.view.width)}
    }
    
    private func addCountryPickerView() {
        view.addSubview(countryPickerView)
        countryPickerView.makeConstraints(leadingAnchor: countryView.leadingAnchor , centerYAnchor: countryView.centerYAnchor,
                                          padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        countryPickerView.hostViewController = self
    }

    private func addGetCodeButton(){
        view.addSubview(getCodeButton)
        getCodeButton.centerXInSuperview()
        getCodeButton.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                      padding: UIEdgeInsets(top: 0, left: 0, bottom: .view.padding, right: 0))
    }
    
    // MARK: - Actions
    //
    private func getCodeButtonTapped(){
        guard self.viewModel.isPhoneNumberValid else {
            let message = "Enter Valid Phone Number"
            self.phoneNumberTextField.becomeFirstResponder()
            self.phoneNumberTextField.setState(.fail, with: message, for: .editing)
            return
        }
       
        self.viewModel.request(method: .get)
            .sink { [ unowned self ] response in
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

extension PhoneViewController : UITextFieldDelegate {
    // MARK: - UITextFieldDelegate
    //
    // limit the carachters count that text field can hold
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return prospectiveText.count <= 11
    }
}

extension PhoneViewController {
    // MARK: - Bind ViewModel Output
    //
    private func bindViewModelOutput() {
        viewModel.onPhoneNumberChanged { isPhoneNumberValid in
            if isPhoneNumberValid {
                self.phoneNumberTextField.setState(.success, for: .editing)
                self.phoneNumberTextField.setState(.success, for: .normal)
                self.endEditing()
            }
        }
        
        
    }
}

extension PhoneViewController {
    // MARK: - Bind ViewModel Input
    //
    private func bindViewModelInput() {
        phoneNumberTextField.addTarget(self, action: #selector(self.phoneNumberTextFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    @objc private func phoneNumberTextFieldEditingChanged(_ sender: ICinemaTextField) {
        self.viewModel.didChange(phoneNumber: sender.text!)
    }
}

