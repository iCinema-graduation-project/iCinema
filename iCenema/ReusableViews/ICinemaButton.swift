//
//  icinemaButton.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit
import SwiftUI

class ICinemaButton: UIView {
    init(title: String,  action: @escaping () -> Void) {
        super.init(frame: .zero)
        let iCinemaButtonView = ICinemaButtonView(title: title, action: action).hostigView()
        addSubview(iCinemaButtonView)
        iCinemaButtonView.fillSuperviewConstraints()
        sizeConstraints(width: CGFloat.iCinemaButton.size.width + 2,
                        height: CGFloat.iCinemaButton.size.height + 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct ICinemaButtonView: View {
    let title: String
    let action: () -> Void
    let size: CGSize
    
    @State var animate = false
    
    init(title: String, size: CGSize = CGFloat.iCinemaButton.size,
         action: @escaping () -> Void = {}) {
        self.title = title
        self.size = size
        self.action = action
    }
    
    var body: some View {
        Text(title)
            .frame(width: self.size.width, height: self.size.height)
            .background(Color(uiColor: .iCinemaYellowColor))
            .foregroundColor(Color(uiColor: .iCinemaTextColorReverce))
            .cornerRadius(CGFloat.iCinemaButton.cornerRadius)
            .shadow(radius: 0.5, x: 1, y: 1)
            .addScaleAnimationOnTapGesture(animate: $animate, action: self.action)
            .shadow(color: Color(uiColor: .iCinemaYellowColor), radius: 4)
//            .font(width > 100 ? .subheadline : .caption)
            .font(Font(size.width > 100 ? UIFont.button : UIFont.smallButton))
    }
    
}

    

