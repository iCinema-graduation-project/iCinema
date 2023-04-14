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
    // MARK: - Properties
    var gender: Gender = .female
   
    // MARK: - Views
    //
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = .newUser.descriptionLabel
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
    
    private let fullNameTextField: ICinemaTextField = ICinemaTextField(placeholder: .newUser.fullName)
    
    private let ageTextField: ICinemaTextField = {
        let ageField = ICinemaTextField(placeholder: .newUser.age)
        ageField.keyboardType = .numberPad
        ageField.font = .textfeild
        return ageField
    }()
    

    /// Create Account Button
    private lazy var createAccountButton = ICinemaButton(title: .newUser.createAccount, action: self.createAccountButtonTapped)
    
    
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
        descriptionLabel.makeDescreptionLabel()
        descriptionLabel.centerXInSuperview()
        descriptionLabel.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                         padding: UIEdgeInsets(top: .view.padding.top, left: 0,
                                                               bottom: 0, right: 0))
    }
    
    private func addTextFieldsStackView() {
        view.addSubview(TextFieldsStackView)
        TextFieldsStackView.centerXInSuperview()
        TextFieldsStackView.makeConstraints(topAnchor: descriptionLabel.bottomAnchor,
                                            padding: UIEdgeInsets(top: .view.padding.top, left: 0,
                                                                  bottom: 0, right: 0))
    
        TextFieldsStackView.addArrangedSubview(fullNameTextField)
        TextFieldsStackView.addArrangedSubview(ageTextField)
        let genderView = GenderView(presenterView: view)
        TextFieldsStackView.addArrangedSubview(genderView.view)
        TextFieldsStackView.arrangedSubviews.forEach {$0.widthConstraints(.view.width)}
        fullNameTextField.font = .textfeild
        
        genderView.updateGenders()

    }
    

    
    private func addCreateAccountButton(){
        view.addSubview(createAccountButton)
        createAccountButton.centerXInSuperview()
        createAccountButton.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                            padding: UIEdgeInsets(top: 0, left: 0,
                                                                  bottom: .view.padding.bottom, right: 0))
    }
    
    // MARK: - Actions
    func createAccountButtonTapped() {
        self.coordinator?.push()
    }
    
}




