//
//  SignInViewController.swift
//  FoodRecipe_UIKit
//
//  Created by Ahmed Yamany on 20/05/2023.
//

import UIKit
import Coordinator

class SignInViewController: ICinemaViewController {
    // MARK: - Views
    //
    @IBOutlet weak var textFieldsStackView: UIStackView!
    var emailTextField: UITextField = .init()
    var passwordTextField: UITextField = .init()
    var signInButton: UIButton = .init()

    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .iCinemaBackgroundColor
        self.addTextFieldsStackViewArrangedViews()
        self.updateTextFields()
    }

    // MARK: - Update UI
    /**
     actually i tried to make this with Xib but xcode has a bug with it
     */
    private func addTextFieldsStackViewArrangedViews() {
        textFieldsStackView.addArrangedSubview(emailTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        textFieldsStackView.addArrangedSubview(signInButton)
    }
    private func updateTextFields() {
        self.updateEmailTextField()
        self.updatePasswordTextField()
        self.updateSignInButton()
    }
    private func updateEmailTextField() {
        emailTextField.placeholder = L10n.App.Signin.emailTextFieldPlaceholder
        emailTextField.applyStyle(.primary(L10n.App.Signin.emailTextFieldTitle))
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
    }
    private func updatePasswordTextField() {
        passwordTextField.placeholder = L10n.App.Signin.passwordTextFieldPlaceholder
        passwordTextField.applyStyle(.primary(L10n.App.Signin.passwordTextFieldTitle))
        passwordTextField.makeSecured()
    }
    private func updateSignInButton() {
        signInButton.applyButtonStyle(.primary, filled: true)
        signInButton.heightConstraints(48)
        signInButton.setTitle(L10n.App.Signin.signInButton, for: .normal)
        signInButton.addTarget(self, action: #selector(self.signInButtonDidTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func signInButtonDidTapped(_ sender: UIButton) {
        self.coordinator?.push()
    }

}
