//
//  PhoneViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit
import SwiftUI


enum Gender: String{
    case male = "Male"
    case female = "Female"
}

class NewUserViewController: ICinemaViewController {
    // MARK: - Properties
    var gender: Gender = .female
   
    // MARK: - Views
    //
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = .newUserDescriptionLabel
        label.tintColor = .iCinemaTextColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.widthConstraints(.view.width)
        label.font = .callout
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
    
    private let fullNameTextField: ICinemaTextField = ICinemaTextField(placeholder: .fullName)
    
    private let ageTextField: ICinemaTextField = {
        let ageField = ICinemaTextField(placeholder: .age)
        ageField.keyboardType = .numberPad
        ageField.font = .textfeild
        return ageField
    }()
    
    /// Gender Select
    private let genderView: ICinemaTextField = {
        let textfield = ICinemaTextField(placeholder: .gender)
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
        button.setTitle(.female, for: .normal)
        button.titleLabel?.font = .callout
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
        button.setTitle(.male, for: .normal)
        button.titleLabel?.font = .callout
        return button
    }()
    
    private lazy var genderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [femaleButton, maleButton])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.arrangedSubviews.forEach { $0.tintColor = .iCinemaTextColor }
        return stackView
    }()
    
    /// Create Account Button
    private lazy var createAccountButton = ICinemaButton(title: .createAccount, action: self.createAccountButtonTapped)
    
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.addTitleView(title: .newUser)
        addDescriptionLabel()
        addTextFieldsStackView()
        addGenderStackView()
        addCreateAccountButton()

        femaleButton.isSelected = true
    }
    
    // MARK: - View Helper Functions
    //
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
    
        TextFieldsStackView.addArrangedSubview(fullNameTextField)
        TextFieldsStackView.addArrangedSubview(ageTextField)
        TextFieldsStackView.addArrangedSubview(genderView)
        TextFieldsStackView.arrangedSubviews.forEach {$0.widthConstraints(.view.width)}
        fullNameTextField.font = .textfeild
    }
    
    private func addGenderStackView() {
        view.addSubview(genderStackView)
        genderStackView.makeConstraints(centerXAnchor: genderView.centerXAnchor, centerYAnchor: genderView.centerYAnchor)
    }
    
    private func addCreateAccountButton(){
        view.addSubview(createAccountButton)
        createAccountButton.centerXInSuperview()
        createAccountButton.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: .view.padding, right: 0))
    }
    
    
    // MARK: - Actins
    func createAccountButtonTapped() {
        self.coordinator?.push()
    }
    
}

struct NewUserView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return NewUserViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView()
            .ignoresSafeArea()
    }
}




