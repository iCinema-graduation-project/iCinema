//
//  PhoneViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit


enum Gender: String{
    case male = "Male"
    case female = "Female"
}

class NewUserViewController: ICinemaViewController {
    
    // MARK: - Views
    //
    private let descriptionLabel: UILabel = UILabel()
    private let TextFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = .view.spacing
        return stackView
    }()
    
    private let fullNameTextField: ICinemaTextField = ICinemaTextField(placeholder: .newUser.fullName)
    
    private let ageTextField: ICinemaTextField = {
        let ageField = ICinemaTextField(placeholder: .newUser.age)
        ageField.keyboardType = .numberPad
        ageField.font = .textfeild
        return ageField
    }()
    
    private lazy var genderView = GenderView(presenterView: view)

    private lazy var createAccountButton = ICinemaButton(title: .saveEdits, action: self.createAccountButtonTapped)
    
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.addTitleView(title: .newUser.newUser)
        addDescriptionLabel()
        addTextFieldsStackView()
        addCreateAccountButton()
    }
    
    // MARK: - View Helper Functions
    //
    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.text = .newUser.descriptionLabel
        descriptionLabel.makeDescreptionLabel()
        descriptionLabel.centerXInSuperview()
        descriptionLabel.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                         padding: CGFloat.view.padding)
    }
    
    private func addTextFieldsStackView() {
        view.addSubview(TextFieldsStackView)
        TextFieldsStackView.centerXInSuperview()
        TextFieldsStackView.makeConstraints(topAnchor: descriptionLabel.bottomAnchor,
                                            padding: CGFloat.view.padding)
    
        TextFieldsStackView.addArrangedSubview(fullNameTextField)
        TextFieldsStackView.addArrangedSubview(ageTextField)
        TextFieldsStackView.addArrangedSubview(genderView.view)
        TextFieldsStackView.arrangedSubviews.forEach {$0.widthConstraints(.view.width)}
        fullNameTextField.font = .textfeild
        
        genderView.updateGenders()
        
    }
    

    private func addCreateAccountButton(){
        view.addSubview(createAccountButton)
        createAccountButton.addToitsSuperView()
    }
    
    // MARK: - Actions
    func createAccountButtonTapped() {
        self.coordinator?.push()
    }
    
}




