//
//  UIView+FillSuperviewConstraints.swift
//  Book Nexus
//
//  Created by Ahmed Yamany on 05/01/2023.
//

import UIKit

public extension UIView{
    
    func fillSuperviewConstraints(padding: UIEdgeInsets = .zero) {
        self.fillYSuperViewConstraints(paddingTop: padding.top, paddingBottom: padding.bottom)
        self.fillXSuperViewConstraints(paddingLeft: padding.left, paddingRight: padding.right)
    }
    
    func fillXSuperViewConstraints(paddingLeft: CGFloat = 0, paddingRight: CGFloat = 0){
        translatesAutoresizingMaskIntoConstraints = false

        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: paddingLeft).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -paddingRight).isActive = true
        }
    }
    
    func fillYSuperViewConstraints(paddingTop: CGFloat = 0, paddingBottom: CGFloat = 0){
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: paddingTop).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -paddingBottom).isActive = true
        }
        
      
    }
}
