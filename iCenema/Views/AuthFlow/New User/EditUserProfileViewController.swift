//
//  PhoneViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit
import SwiftUI
import SPAlert

enum Gender: String {
    case male = "male"
    case female = "female"
    case none = ""
}

class EditUserProfileViewController: ICinemaViewController {
    
    // MARK: - Views
    //
    private let scrollView = UIScrollView()
    
    let avatarView = AvatarView(size: 120)

    private let TextFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = .view.spacing
        return stackView
    }()
    
    private let fullNameTextField: ICinemaTextField = ICinemaTextField(placeholder: .newUser.fullName)
    
    private let ageTextField: ICinemaTextField = ICinemaTextField(placeholder: .newUser.age)
    
    private lazy var genderView = GenderView(presenterView: view)
    
    private lazy var interstsView = InterstsView(viewModel: self.viewModel)
                                                .hostigView()
    
    private lazy var createAccountButton = ICinemaButton(title: .saveEdits, action: self.createAccountButtonTapped)
    
    // MARK: - Properties
    let viewModel = EditUserProfileViewModel()
    
    // MARK: - Life Cycle
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TabBarViewModel.shared.hide()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        self.genderView.delegate = self
    }
    
    // MARK: - Update UI
    //
    private func updateUI() {
        navigationItem.addTitleView(title: .newUser.newUser)
        self.addScrollView()
        self.updateAvatarView()
        self.updateFullNameTextField()
        self.updateAgeTextField()
        self.addStackViewArrangedViews()
        self.updateInterstsView()
        self.addCreateAccountButton()
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.fillSuperviewConstraints()
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: Constants.screenBounds.width,
                                        height: Constants.screenBounds.height + 100)        
    }

    private func updateAvatarView() {
        avatarView.indicatorButton.tintColor = .iCinemaYellowColor
    }
    
    private func updateFullNameTextField() {
        fullNameTextField.font = .textfeild
        fullNameTextField.addTarget(self, action: #selector(self.fullNameTFEditingChanged), for: .editingChanged)
    }
    
    private func updateAgeTextField() {
        ageTextField.keyboardType = .numberPad
        ageTextField.font = .textfeild
        ageTextField.addTarget(self, action: #selector(self.ageTFEditingChanged), for: .editingChanged)
    }
    
    private func addStackViewArrangedViews() {
        scrollView.addSubview(TextFieldsStackView)
        TextFieldsStackView.centerXInSuperview()
        TextFieldsStackView.makeConstraints(topAnchor: scrollView.topAnchor)
        
        TextFieldsStackView.addArrangedSubview(avatarView)
        TextFieldsStackView.addArrangedSubview(fullNameTextField)
        TextFieldsStackView.addArrangedSubview(ageTextField)
        TextFieldsStackView.addArrangedSubview(genderView.view)
        TextFieldsStackView.addArrangedSubview(interstsView)
        interstsView.heightConstraints(400)
        TextFieldsStackView.arrangedSubviews[1...].forEach {$0.widthConstraints(.view.width)}
    
        genderView.updateGenders()
    }
    
    private func updateInterstsView() {
        interstsView.backgroundColor = .clear
    }
    
    private func addCreateAccountButton(){
        view.addSubview(createAccountButton)
        createAccountButton.addToitsSuperView()
    }
    
    // MARK: - Actions
    func createAccountButtonTapped() {
        
        if self.viewModel.fullName.count < 3 {
            
            self.fullNameTextField.setState(.fail, with: "", for: .editing)
            self.fullNameTextField.becomeFirstResponder()
            
        } else if self.viewModel.age < 10 {
            
            self.ageTextField.setState(.fail, with: "", for: .editing)
            self.ageTextField.becomeFirstResponder()
            
        } else if self.viewModel.gender == .none {
            
            self.genderView.view.setState(.fail, for: .disabled)
            self.genderView.view.becomeFirstResponder()
            
        } else if self.viewModel.selectedCategories.count == 0 {
            
            SPAlertView(message: "select Genre before contenu").present()
            
        } else {
            self.viewModel.updateProfile { result in
                switch result {
                case .success(let success):
                    print(success)
                    self.coordinator?.push()
                case .failure(let failure):
                    print(NetworkError.getErrorMessage(from: failure))
                }
            }
        }
        
    }
    
    @objc private func fullNameTFEditingChanged() {
        self.viewModel.fullName = fullNameTextField.text ?? ""
    }
    
    @objc private func ageTFEditingChanged() {
        self.viewModel.age = Int(ageTextField.text ?? "") ?? 0
    }
        
}

// MARK: - GenderViewDelegate
extension EditUserProfileViewController: GenderViewDelegate {
    func genderDidChanged(_ gender: Gender) {
        self.viewModel.gender = gender
    }
}

// MARK: - AvatarViewDelegate
extension EditUserProfileViewController: AvatarViewDelegate {
    func imageDidChanged(_ image: UIImage) {
        self.viewModel.image = image
    }
}



struct NewUserView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: EditUserProfileViewController())
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
