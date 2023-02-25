//
//  +addTitleView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/02/2023.
//

import UIKit

extension UINavigationItem {
    public func addTitleView(title: String) {
        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .iCinemaYellowColor
        titleView = label
    }
    
    public func addTitleView(view: UIView) {
        titleView = view
    }
    
}
