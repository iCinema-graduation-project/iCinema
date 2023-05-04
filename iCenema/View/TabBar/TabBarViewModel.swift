//
//  TabBarViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/03/2023.
//

import SwiftUI


class TabBarViewModel: ObservableObject {
    static let shared = TabBarViewModel()
    
    @Published var isHidden: Bool = false
    
    @Published var selectedTabIndex: Int = 1 {
        didSet {
            self.xAxis = self.readers.reversed()[selectedTabIndex].frame(in: .global).minX + 15
        }
    }
    
    @Published var xAxis: CGFloat = 0

    @Published var readers: [GeometryProxy] = []
    
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

