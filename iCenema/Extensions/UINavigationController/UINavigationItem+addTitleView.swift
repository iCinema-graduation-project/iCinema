//
//  +addTitleView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/02/2023.
//

import UIKit

/// Extend the UINavigationItem class with helper methods to add a title view
extension UINavigationItem {
    
    /// Add a new UILabel instance as the title view with the specified title
    public func addTitleView(title: String) {
        let label = UILabel()
        label.text = title
        label.font = .title2
        label.textColor = .iCinemaYellowColor
        titleView = label
    }
    
    /// Add a specified UIView instance as the title view
    public func addTitleView(view: UIView) {
        titleView = view
    }
    
}
