//
//  UIView+addAnimate.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/02/2023.
//

import UIKit

extension UIView {
    func addAnimate(completion: @escaping () -> Void = {}) {
        let xScale : CGFloat = 1.025
        let yScale : CGFloat  = 1.05

        UIView.animate(withDuration: 0.1, animations: {
            let transformation = CGAffineTransform(scaleX: xScale, y: yScale)
            self.transform = transformation
        }) { (_) in
            let transformation = CGAffineTransform(scaleX: 1, y: 1)
            self.transform = transformation
            completion()
        }
    }
}
