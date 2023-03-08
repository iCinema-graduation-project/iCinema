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
        
        guard let iCinemaButtonView = UIHostingController(rootView: ICinemaButtonView(title: title, action: action)).view else { return }
        addSubview(iCinemaButtonView)
        iCinemaButtonView.fillSuperviewConstraints()
        sizeConstraints(width: .iCinemaButtonWidth + 5, height: .iCinemaButtonHeight + 5)        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct ICinemaButtonView: View {
    let title: String
    let action: () -> Void
    let width: CGFloat
    let height: CGFloat
    
    @State var animate = false
    
    init(title: String,
         width: CGFloat = .iCinemaButtonWidth,
         height: CGFloat = .iCinemaButtonHeight,
         action: @escaping () -> Void = {}) {
        self.title = title
        self.width = width
        self.height = height
        self.action = action
    }
    
    var body: some View {
        Text(title)
            .frame(width: self.width, height: self.height)
            .background(Color(uiColor: .iCinemaYellowColor))
            .foregroundColor(Color(uiColor: .iCinemaTextColorReverce))
            .cornerRadius(self.width / CGFloat.iCinemaButtonCornerRadius)
            .shadow(radius: 0.5, x: 1, y: 1)
            .scaleEffect(animate ? 1 : 1.05)
            .shadow(color: Color(uiColor: .iCinemaYellowColor), radius: 4)
            .font(width > 100 ? .subheadline : .caption)
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.1)) {
                    animate = true
                }
                animate = false
                self.action()
        }
        
    }

    
}
