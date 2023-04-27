//
//  UserProfileViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 14/04/2023.
//

import UIKit
import SwiftUI

final class UserProfileViewController: ICinemaViewController {
    
    // MARK: - Views
    //
    private let scrollView = UIScrollView()
    
    private let profileImageView: UIImageView = UIImageView()
    
    private let TextFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = .view.spacing
        return stackView
    }()
    
    private let fullNameTextField: ICinemaTextField = ICinemaTextField(placeholder: .newUser.fullName)
    
    private let phoneNumberTextField: ICinemaTextField = {
        let textfield = ICinemaTextField(placeholder: .phone.phoneNumber)
        textfield.keyboardType = .phonePad
        textfield.font = .textfeild
        return textfield
    }()
    
    private let ageTextField: ICinemaTextField = {
        let ageField = ICinemaTextField(placeholder: .newUser.age)
        ageField.keyboardType = .numberPad
        ageField.font = .textfeild
        return ageField
    }()
    
    private lazy var genderView = GenderView(presenterView: view)

    private lazy var saveButton = ICinemaButton(title: .saveEdits, action: self.saveEditsButtonTapped)
    
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TabBarViewModel.shared.hide()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.addTitleView(title: .profile)
        self.updateUI()
    
    }
    
    // MARK: - Update UI
    private func updateUI() {
        self.addScrollView()
        self.updateProfileImageView()
        self.addTextFieldsStackView()
        self.addSaveEditsButton()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.scrollViewTapGeture))
        scrollView.addGestureRecognizer(gesture)
    
    }
    
    @objc private func scrollViewTapGeture() {
        self.view.endEditing(true)
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.fillSuperviewConstraints()
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: Constants.screenBounds.width,
                                        height: Constants.screenBounds.height)

    }
    
    private func updateProfileImageView() {
        scrollView.addSubview(profileImageView)
        profileImageView.image = UIImage(named: "profile")
        profileImageView.makeCircleImage(withWidth: 100, lineWidth: 3, borderColor: .iCinemaYellowColor)
        profileImageView.centerXInSuperview()
    }
    
    private func addTextFieldsStackView() {
        scrollView.addSubview(TextFieldsStackView)
        TextFieldsStackView.centerXInSuperview()
        TextFieldsStackView.makeConstraints(topAnchor: profileImageView.bottomAnchor,
                                            padding: UIEdgeInsets(top: .view.padding.top,
                                                                  left: 0,
                                                                  bottom: 0,
                                                                  right: 0))
    
        TextFieldsStackView.addArrangedSubview(phoneNumberTextField)
        TextFieldsStackView.addArrangedSubview(fullNameTextField)
        TextFieldsStackView.addArrangedSubview(ageTextField)
        TextFieldsStackView.addArrangedSubview(genderView.view)
        TextFieldsStackView.arrangedSubviews.forEach {$0.widthConstraints(.view.width)}
    
        fullNameTextField.font = .textfeild
        genderView.updateGenders()
    }
    
    private func addSaveEditsButton(){
        view.addSubview(saveButton)
        saveButton.centerXInSuperview()
        saveButton.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                            padding: UIEdgeInsets(top: 0, left: 0,
                                                                  bottom: .view.padding.bottom, right: 0))
    }
    
    // MARK: - Actions
    func saveEditsButtonTapped() {

    }
    
}


struct UserProfileView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: UserProfileViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .ignoresSafeArea()
    }
}
