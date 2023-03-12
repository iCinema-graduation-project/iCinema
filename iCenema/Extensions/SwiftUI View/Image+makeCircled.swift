//
//  Image+makeCircled.swift
//  iCinema
//
//  Created by Ahmed Yamany on 11/03/2023.
//

import SwiftUI


extension Image {
    @ViewBuilder func makeCircled(size: CGSize,
                                  strockColor: Color = .white,
                                  strockSpacing: CGFloat = 2,
                                  lineWidth: CGFloat = 1.0) -> some View {
        self.resizable()
            .frame(width: size.width, height: size.height)
            .mask(Circle())
            .overlay {
                Circle()
                    .stroke(strockColor, lineWidth: lineWidth)
                    .frame(width: size.width + strockSpacing, height: size.width + strockSpacing)
            }
            .frame(width: size.width + strockSpacing + 2, height: size.height + strockSpacing + 2)
        
        
    }
}
