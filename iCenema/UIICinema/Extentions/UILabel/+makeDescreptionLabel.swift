//
//  +makeDescreptionLabel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/04/2023.
//

import UIKit.UILabel
import MakeConstraints

extension UILabel {
    func makeDescreptionLabel() {
        textAlignment = .center
        numberOfLines = 0
        textColor = .iCinemaTextColor
        font = .footnote
        centerXInSuperview()
        fillXSuperViewConstraints(paddingLeft: .view.padding.left,
                                  paddingRight: .view.padding.right)
        
        guard let superview = superview else { return }
        makeConstraints(topAnchor: superview.safeAreaLayoutGuide.topAnchor,
                                         padding: CGFloat.view.padding)
    }
}
