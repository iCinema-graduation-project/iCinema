//
//  icinemaButton.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit
import SwiftUI

class ICinemaButton: UIView {
    init(title: String, action: @escaping () -> Void) {
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
    
    @State var animate = false
    
    init(title: String, action: @escaping () -> Void = {}) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Text(title)
            .frame(width: .iCinemaButtonWidth, height: .iCinemaButtonHeight)
            .background(Color(uiColor: .iCinemaYellowColor))
            .foregroundColor(Color(uiColor: .iCinemaTextColorReverce))
            .cornerRadius(.iCinemaButtonCornerRadius)
            .shadow(radius: 0.5, x: 1, y: 1)
            .scaleEffect(animate ? 1 : 1.05)
            .padding()
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.1)) {
                    animate = true
                }
                animate = false
                self.action()
        }
        
    }

    
}
