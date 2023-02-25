//
//  +makeCircleImage.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/02/2023.
//

import UIKit


extension UIImageView {
    func makeCircleImage(withWidth width: CGFloat) -> UIImageView {
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = width / 2
        equalSizeConstraints(width)
        return self
    }
}
