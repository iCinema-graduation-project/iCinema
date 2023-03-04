//
//  TabBarViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/03/2023.
//

import SwiftUI

class TabBarViewModel: ObservableObject {
    @Published var isHidden: Bool = false
    
    func hide() {
        withAnimation(.easeInOut) {
            isHidden = true
        }
    }
    
    func show() {
        withAnimation(.easeInOut) {
            isHidden = false
        }
    }
}

