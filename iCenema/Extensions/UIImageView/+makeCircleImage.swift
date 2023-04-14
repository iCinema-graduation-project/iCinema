//
//  +makeCircleImage.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/02/2023.
//

import UIKit


extension UIImageView {
    @discardableResult
    func makeCircleImage(withWidth width: CGFloat, lineWidth: CGFloat = 1.5) -> UIImageView {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = width / 2
        equalSizeConstraints(width)
        layer.borderColor = UIColor.iCinemaYellowColor.cgColor
        layer.borderWidth = lineWidth
        return self
    }
}
