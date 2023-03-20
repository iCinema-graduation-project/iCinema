//
//  Axis.swift
//  iCinema
//
//  Created by Ahmed Yamany on 18/03/2023.
//

import SwiftUI

struct Axis: View {
    @Environment(\.colorScheme) var colorScheme

    let rowSize: CGFloat = 25
    
    let array = [
        [-1, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, -1, -1, -1 ,-1],
        [-1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, -1],
        [0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0, -1, -1, 0, 0],
        [0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0, -1, -1, 0, 0],
        [0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0, -1, -1, 0, 0],
    ]
    
    
    var body: some View {
        VStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(array, id: \.self) { list in
                                HStack {
                                    ForEach(list, id: \.self) { value in
                                        
                                        Image(systemName: value == 0 ? "rectangle.fill" : "")
                                            .font(.system(size: rowSize))
                                            .frame(width: rowSize, height: rowSize)
                                    }
                                    
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .frame(height: 300)

            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue)
    }
}

struct Axis_Previews: PreviewProvider {
    static var previews: some View {
        Axis()
    }
}
