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
    // MARK: - Views
    //
    /// Description Label
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = LanguageManager.newUserDescriptionLabel
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
    
    private let fullNameTextField: ICinemaTextField = ICinemaTextField(placeholder: LanguageManager.fullName)
    
    private let ageTextField: ICinemaTextField = {
        let ageField = ICinemaTextField(placeholder: LanguageManager.age)
        ageField.keyboardType = .numberPad
        return ageField
    }()
    
    /// Gender Select
    private let genderView: ICinemaTextField = {
        let textfield = ICinemaTextField(placeholder: LanguageManager.gender)
        textfield.text = "."
        textfield.isEnabled = false
        textfield.setState(.normal, for: .disabled)
        textfield.setTextColor(.clear, for: .disabled)
        return textfield
    }()
    
    private lazy var femaleButton: RadioButton = {
        let button = RadioButton(onSelected: { isSelected in
            if isSelected {
                self.maleButton.isSelected = false
                self.gender = .female
            }
        })
        button.setTitle(LanguageManager.female, for: .normal)
        return button
    }()
    
    private lazy var maleButton: RadioButton = {
        let button = RadioButton { isSelected in
            if isSelected {
                self.femaleButton.isSelected = false
                self.gender = .male
            }
        }
        button.setTitle(LanguageManager.male, for: .normal)
        return button
    }()
    
    private lazy var genderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [femaleButton, maleButton])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.arrangedSubviews.forEach { $0.tintColor = ColorManager.textColor }
        return stackView
    }()
    
    /// Create Account Button
    private let createAccountButton = ICinemaButton(title: LanguageManager.createAccount)
    
    // MARK: - Properties
    var gender: Gender = .female
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavigationTitleView(title: LanguageManager.newUser)
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
                                         padding: UIEdgeInsets(top: SizeManager.viewPadding, left: 0, bottom: 0, right: 0))
    }
    
    private func addTextFieldsStackView() {
        view.addSubview(TextFieldsStackView)
        TextFieldsStackView.centerXInSuperview()
        TextFieldsStackView.makeConstraints(topAnchor: descriptionLabel.bottomAnchor,
                                            padding: UIEdgeInsets(top: SizeManager.viewPadding, left: 0, bottom: 0, right: 0))
    
        TextFieldsStackView.addArrangedSubview(fullNameTextField)
        TextFieldsStackView.addArrangedSubview(ageTextField)
        TextFieldsStackView.addArrangedSubview(genderView)
        TextFieldsStackView.arrangedSubviews.forEach {$0.widthConstraints(SizeManager.textWidth)}
    }
    
    private func addGenderStackView() {
        view.addSubview(genderStackView)
        genderStackView.makeConstraints(centerXAnchor: genderView.centerXAnchor, centerYAnchor: genderView.centerYAnchor)
    }
    
    private func addCreateAccountButton(){
        view.addSubview(createAccountButton)
        createAccountButton.centerXInSuperview()
        createAccountButton.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: SizeManager.viewPadding, right: 0))
        createAccountButton.addTarget(self, action: #selector(self.createAccountButtonTapped(_:)), for: .touchUpInside)
        
    }
    
    
    // MARK: - Actins
    @objc func createAccountButtonTapped(_ sender: ICinemaButton) {
        sender.addAnimate {
            self.coordinator?.push()
        }
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




