//
//  UIView+centerInSuperviewConstraints.swift
//  Book Nexus
//
//  Created by Ahmed Yamany on 05/01/2023.
//

import UIKit


public extension UIView {
    
    @discardableResult
    func centerInSuperview(size: CGSize = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchoredConstraints = AnchoredConstraints()

        if let superview = superview {
            anchoredConstraints.centerX = centerXAnchor.constraint(equalTo: superview.centerXAnchor)
            anchoredConstraints.centerY = centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.centerX, anchoredConstraints.centerY, anchoredConstraints.width, anchoredConstraints.height].forEach{$0?.isActive = true}

        return anchoredConstraints
    }
    
    @discardableResult
    func centerXInSuperview() -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let constraint = centerXAnchor.constraint(equalTo: superview.centerXAnchor)
            constraint.isActive = true
            return constraint
        }
        return nil
    }
    
    @discardableResult
    func centerYInSuperview() -> NSLayoutConstraint? {
        translatesAutoresizingMaskIntoConstraints = false
         if let superview = superview {
             let constraint = centerYAnchor.constraint(equalTo: superview.centerYAnchor)
             constraint.isActive = true
             return constraint
         }
        return nil
    }
}
