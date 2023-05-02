//
//  +addUIRefreshControl.swift
//  iCinema
//
//  Created by Ahmed Yamany on 02/05/2023.
//

import UIKit

extension UICollectionView {
    public func addUIRefreshControl(target: Any?, action: Selector, for event: UIControl.Event) {
        refreshControl = UIRefreshControl()
        alwaysBounceVertical = true
        refreshControl?.tintColor = .iCinemaYellowColor
        refreshControl?.addTarget(target, action: action, for: event)
    }
}
