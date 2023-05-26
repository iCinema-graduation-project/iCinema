//
//  UITextField+Style.swift
//  FoodRecipe_UIKit
//
//  Created by Ahmed Yamany on 20/05/2023.
//

import UIKit
import MakeConstraints

extension UITextField {
    enum Style {
        case primary(String)
    }

    func applyStyle(_ style: Style) {
        switch style {
        case .primary(let title):
            self.applyPrimaryStyle(title)
        }
    }
}

extension UITextField {
    private func applyPrimaryStyle(_ title: String) {
        // perform border
        layer.cornerRadius = 12.0
        layer.borderColor = UIColor.iCinemaTextColor.cgColor
        layer.borderWidth = 1.4
        textColor = UIColor.iCinemaTextColor

        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(string: "\(placeholder)",
                                                       attributes: [
                                                        .font: UIFont.body,
                                                        .foregroundColor: UIColor.darkGray
                                                       ])
        }
        heightConstraints(54)
        addLeftPadding(20)

        // add title label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = .iCinemaTextColor
        titleLabel.font = .textfeild
        addSubview(titleLabel)
        titleLabel.makeConstraints(bottomAnchor: topAnchor,
                                   leadingAnchor: leadingAnchor,
                                   padding: UIEdgeInsets(top: 0,
                                                         left: 0,
                                                         bottom: 5,
                                                         right: 0))
    }
}

extension UITextField {
    func makeSecured() {
        let button = UIButton()
        button.setTitleColor(textColor, for: .normal)
        button.tintColor = textColor
        addSubview(button)
        button.centerYInSuperview()
        button.makeConstraints(trailingAnchor: trailingAnchor,
                               padding: UIEdgeInsets(top: 0, left: 0,
                                                     bottom: 0, right: 10))
        button.addTarget(self, action: #selector(self.securedButtonAction), for: .touchUpInside)
        securedButtonAction(button)
    }
    func addLeftPadding(_ padding: CGFloat) {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: padding).isActive = true
        leftView = view
        leftViewMode = .always
    }
    func addRightPadding(_ padding: CGFloat) {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: padding).isActive = true
        rightView = view
        rightViewMode = .always
    }
    @objc private func securedButtonAction(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        if isSecureTextEntry {
            sender.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            sender.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
}
