//
//  File.swift
//  iCinema
//
//  Created by Ahmed Yamany on 02/05/2023.
//

import SwiftUI

/**
 * This class is responible for showing a custom Alert View
 * you can custom its content view using SwiftUI Views
 */
open class ICinemaAlert {
    
    private var yConstraint: NSLayoutConstraint?

    public let superView = UIApplication.shared.keyWindow?.rootViewController?.view
    public var view: UIView?
    
    let width: CGFloat
    let height: CGFloat
    init(width:CGFloat = 342, height: CGFloat = 220) {
        self.width = width
        self.height = height
    }
    
    public func show<Content: View>(content: @escaping () -> Content) {

        self.view = {
           VStack {
               ZStack {
                   Button {
                       self.hide()
                   } label: {
                       Image(systemName: "x.circle")
                           .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                           .padding(10)
                   }
                   .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topTrailing)

                   
                   content()
               }
           }
           .frame(width: self.width, height: self.height)
           .background(Color(uiColor: .iCinemaSecondBackgroudColor))
           .addBorder(withColor: Color(uiColor: .iCinemaYellowColor), height: self.height)
           .frame(width: self.width)

       }().hostigView()
        
        self.show()
    }
    
    private func show() {
        guard let view = self.view else { return }
        view.backgroundColor = .clear
        superView?.addSubview(view)

        UIView.animate(withDuration: 0, delay: 0) {
            view.centerXInSuperview()
            
            self.yConstraint = view.centerYInSuperview()
            self.yConstraint?.constant = view.height
            view.layoutIfNeeded()
            self.superView?.layoutIfNeeded()
            
        } completion: {  _ in
            UIView.animate(withDuration: 0.3, delay: 0) {
                self.yConstraint?.constant = 0
                view.layoutIfNeeded()
                self.superView?.layoutIfNeeded()
            }
            
        }
    }
    
    public func hide() {
        guard let view = self.view else { return }

        UIView.animate(withDuration: 0.3, delay: 0) {
            self.yConstraint?.constant = view.height
            view.layoutIfNeeded()
            self.superView?.layoutIfNeeded()
        }completion: { _ in
            view.removeFromSuperview()
        }

    }
    
    
}



@available(iOS 13.0, *)
public struct ICinemaAlertView<Content: View>: View {
    @ViewBuilder var content: Content

    public var body: some View {
        VStack {
            content
        }
        .frame(width: 342, height: 220)
        .background(Color(uiColor: .iCinemaSecondBackgroudColor))
        .addBorder(withColor: Color(uiColor: .iCinemaYellowColor), height: 220)
        .frame(width: 342)

    }
}
