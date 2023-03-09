//
//  addScaleAnimationOnTapGesture.swift
//  iCinema
//
//  Created by Ahmed Yamany on 09/03/2023.
//

import SwiftUI

extension View {
    @ViewBuilder func addScaleAnimationOnTapGesture( animate: Binding<Bool>,
                                                     action: @escaping () -> Void) -> some View {
        self.scaleEffect(animate.wrappedValue ? 1 : 1.05)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                animate.wrappedValue = true
            }
            animate.wrappedValue = false
            action()
        }
        
    }
}

