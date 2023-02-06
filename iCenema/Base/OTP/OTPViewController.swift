//
//  OTPViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/02/2023.
//

import UIKit
import SwiftUI

class OTPViewController: ViewController {
    // MARK: - Views
    //
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = LanguageManager.otpDescriptionLabel
        label.tintColor = ColorManager.textColor
        label.numberOfLines = 0
        label.textAlignment = .center
        label.widthConstraints(SizeManager.textWidth)
        return label
    }()
    
    private let verificationCodeStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fillEqually
        stackview.spacing = 10
        return stackview
    }()

    private let confirmButton = iCinemaButton(title: LanguageManager.confirm)
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addNavigationTitleView(title: LanguageManager.verification)
        confirmButton.addTarget(self, action: #selector(self.confirmButtonTapped(_:)), for: .touchUpInside)
        addDescriptionLabel()
        addverificationCodeStackView()
        addConfirmButton()

        for i in 0...4 {
            let input = iTextField(placeholder: "")
            input.delegate = self
            verificationCodeStackView.addArrangedSubview(input)
            input.tag = i
            input.textAlignment = .center
            input.keyboardType = .numberPad
        }
        
    }
    
    // MARK: - Helper Functions
    //
    private func addDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.centerXInSuperview()
        descriptionLabel.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                         padding: UIEdgeInsets(top: SizeManager.viewPadding, left: 0, bottom: 0, right: 0))
    }
    
    private func addverificationCodeStackView() {
        view.addSubview(verificationCodeStackView)
        verificationCodeStackView.widthConstraints(SizeManager.textWidth)
        verificationCodeStackView.centerXInSuperview()
        verificationCodeStackView.makeConstraints(topAnchor: descriptionLabel.bottomAnchor, padding: UIEdgeInsets(top: SizeManager.viewPadding, left: 0, bottom: 0, right: 0))
    }
    
    private func addConfirmButton() {
        view.addSubview(confirmButton)
        confirmButton.centerXInSuperview()
        confirmButton.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: SizeManager.viewPadding, right: 0))
    }
    
    // MARK: - Actions
    //
    @objc private func confirmButtonTapped(_ sender: iCinemaButton) {
        sender.addAnimate {
            self.navigationController?.pushViewController(NewUserViewController(), animated: true)
        }
    }
    
}

// MARK: - UITextFieldDelegate
//
extension OTPViewController : UITextFieldDelegate {
    // limit the count of charecters in text field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return prospectiveText.count <= 1
    }
}


struct OTPView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return OTPViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
            .ignoresSafeArea()
    }
}
