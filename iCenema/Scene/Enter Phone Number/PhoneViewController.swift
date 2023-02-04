//
//  PhoneViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 31/01/2023.
//

import UIKit
import CountryPickerView


class PhoneViewController:  ViewController {
    // MARK: - Views
    //
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = LanguageManager.phoneDescriptionLabel
        label.tintColor = ColorManager.textColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.widthConstraints(SizeManager.textWidth)
        return label
    }()
    
    /// Input Text Fields
    private let TextFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 36
        return stackView
    }()
    
    /// Select Country
    private let countryView: iTextField = {
        let textfield = iTextField(placeholder: LanguageManager.country)
        textfield.text = "."
        textfield.isEnabled = false
        textfield.setState(.normal, for: .disabled)
        textfield.setTextColor(.clear, for: .disabled)
        return textfield
    }()
    
    private let countryPickerView: CountryPickerView = {
        let countryView = CountryPickerView()
        countryView.textColor = ColorManager.textColor
        countryView.showCountryNameInView = true
        countryView.setCountryByCode("EG")
        return countryView
    }()
    
    private let phoneNumberTextField: iTextField = {
        let textfield = iTextField(placeholder: LanguageManager.phoneNumber)
        textfield.keyboardType = .phonePad
        return textfield
    }()
    
    /// button
    private let getCodeButton = iCinemaButton(title: LanguageManager.getCode)
    
    // MARK: - Properites
    //
    lazy var viewModel: PhoneViewModelTypes = PhoneViewModel(onPhoneNumberChanged: { isValid in
        if isValid {
            self.phoneNumberTextField.setState(.success, for: .editing)
            self.phoneNumberTextField.setState(.normal, for: .normal)

        }else {
            self.phoneNumberTextField.setState(.fail, with: "The Phone number is not valid", for: .editing)
            self.phoneNumberTextField.setState(.fail, with: "The Phone number is not valid", for: .normal)

        }
    })

    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavigationTitleView(title: LanguageManager.register)
        
        phoneNumberTextField.delegate = self
        phoneNumberTextField.addTarget(self, action: #selector(self.phoneNumberTextFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addDescriptionLabel()
        addTextFieldsStackView()
        addCountryPickerView()
        addGetCodeButton()
        
    }
    
    // MARK: - Helper Functions
    //
    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.centerXInSuperview()
        descriptionLabel.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                         padding: UIEdgeInsets(top: SizeManager.viewPadding, left: 0, bottom: 0, right: 0))
    }
    
    private func addTextFieldsStackView() {
        view.addSubview(TextFieldsStackView)
        TextFieldsStackView.centerXInSuperview()
        TextFieldsStackView.makeConstraints(topAnchor: descriptionLabel.bottomAnchor,
                                            padding: UIEdgeInsets(top: SizeManager.viewPadding, left: 0, bottom: 0, right: 0))
    
        TextFieldsStackView.addArrangedSubview(countryView)
        TextFieldsStackView.addArrangedSubview(phoneNumberTextField)
        TextFieldsStackView.arrangedSubviews.forEach {$0.widthConstraints(SizeManager.textWidth)}
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
                                      padding: UIEdgeInsets(top: 0, left: 0, bottom: SizeManager.viewPadding, right: 0))
        getCodeButton.addTarget(self, action: #selector(self.getCodeButtonTapped(_:)), for: .touchUpInside)

    }
    
    // MARK: - Actions
    //
    @objc private func getCodeButtonTapped(_ sender: iCinemaButton){
        sender.addAnimate {
            self.navigationController?.pushViewController(OTPViewController(), animated: true)
        }
    }
    
    @objc private func phoneNumberTextFieldEditingChanged(_ sender: iTextField) {
        self.viewModel.inputs.didChange(phoneNumber: sender.text!)
    }
    
}


extension PhoneViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return prospectiveText.count <= 11
    }
}



