//
//  +addBorder.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/03/2023.
//

import UIKit
import SwiftUI

extension View {
    @ViewBuilder func addBorder(withColor color: Color,
                                padding: EdgeInsets = EdgeInsets(top: 0, leading: 0.1, bottom: 1.2, trailing: 0.1),
                                cornorRadius: CGFloat = 16, height: CGFloat) -> some View {
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(color)
                .cornerRadius(CGFloat.view.cornerRadius)

            self
                .cornerRadius(CGFloat.view.cornerRadius)
                .padding(.top, padding.top)
                .padding(.bottom, padding.bottom)
                .padding(.leading, padding.leading)
                .padding(.trailing, padding.trailing)
        }
        .frame(height: height)
    }
}

extension UIView {
    /*
     Allowing a border to be added to a view with specified color and thickness,
     along with customizable offsets for top, bottom, left, and right.
     */
    func addBorder(withColor color: UIColor, borderWidth: CGFloat = 0.2,
                   padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 1.2, right: 0) ) {
        guard let superview = superview else { return }
        
        let view = UIView()
        superview.addSubview(view)

        view.backgroundColor = color
        
        /// This sets the size of the new UIView to match the size of the original view
        view.sizeConstraints(width: self.width + padding.left + padding.right,
                             height: self.height + padding.top + padding.bottom)
        
        
        view.centerXInSuperview()
        view.makeConstraints(topAnchor: superview.topAnchor)
        
        // set rounded corner radius matching to the original view.
        view.layer.masksToBounds = true
        view.layer.cornerRadius = self.layer.cornerRadius
        
        view.layer.borderColor = color.cgColor
        view.layer.borderWidth = borderWidth
        
        self.removeFromSuperview()
        view.addSubview(self)
        self.fillSuperviewConstraints(padding: padding)
        
    }
}
