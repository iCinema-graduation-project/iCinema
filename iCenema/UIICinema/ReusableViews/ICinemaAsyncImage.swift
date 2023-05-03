//
//  ICinemaAsyncImage.swift
//  iCinema
//
//  Created by Ahmed Yamany on 03/05/2023.
//

import SwiftUI

struct ICinemaAsyncImage<Content: View> : View {
    
    let url: URL?
    var addPlaceholder: Bool = true
    let content: (Image) -> Content
    
    
    var body: some View {
        AsyncImage(url: url) { image in
            content(image)
        } placeholder: {
            VStack {
                if addPlaceholder {
                    Image(uiImage: .ICinemaLogo)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.iCinemaSecondBackgroudColor)
        }
    }
}
