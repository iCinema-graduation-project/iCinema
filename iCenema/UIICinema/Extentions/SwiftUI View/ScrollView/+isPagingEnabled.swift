//
//  +isPagingEnabled.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/05/2023.
//

import SwiftUI


struct ScrollViewPagingModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
    }
}

extension ScrollView {
    func isPagingEnabled() -> some View {
        modifier(ScrollViewPagingModifier())
    }
}
