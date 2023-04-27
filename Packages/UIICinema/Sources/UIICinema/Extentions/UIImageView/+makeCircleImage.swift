//
//  +makeCircleImage.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/02/2023.
//

import UIKit


public extension UIImageView {
    @discardableResult
    func makeCircleImage(withWidth width: CGFloat,
                         lineWidth: CGFloat = 1.5,
                         borderColor: UIColor? ) -> UIImageView {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = width / 2
        equalSizeConstraints(width)
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = lineWidth
        return self
    }
}
