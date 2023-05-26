//
//  UIButton+Style.swift
//  FoodRecipe_UIKit
//
//  Created by Ahmed Yamany on 20/05/2023.
//

import UIKit
import MakeConstraints
extension UIButton {
    enum ButtonStyle {
        case primary

    }
}

extension UIButton {
    func applyButtonStyle(_ style: ButtonStyle, filled: Bool = false) {
        switch style {
        case .primary:
            self.applyPrimaryButtonStyle(filled: filled)
        }
    }

    private func applyPrimaryButtonStyle(filled: Bool) {
        backgroundColor = .iCinemaYellowColor
        setTitleColor(.iCinemaTextColorReverce, for: .normal)
        layer.cornerRadius = .iCinemaButton.cornerRadius

        if !filled {
            heightConstraints(.iCinemaButton.size.height)
            widthConstraints(.iCinemaButton.size.width)
        }

        titleLabel?.font = .button
    }

}
