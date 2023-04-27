//
//  ICinemaWalletView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/04/2023.
//

import SwiftUI

struct ICinemaWalletView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State var isAnimate: Bool = false
    
    var body: some View {
        ICinemaView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(LinearGradient(colors: [Color(uiColor: .iCinemaYellowColor),
                                                          Color(uiColor: colorScheme == .dark ? .brown : .gray)],
                                                 startPoint: .bottomTrailing,
                                                 endPoint: .topLeading))
                        VStack {
                            Text("Balance")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text("$720.25")
                                .font(.system(size: 50))
                                .fontWeight(.semibold)
                        }
                        .padding()
                        .foregroundColor(Color(uiColor: .iCinemaTextColorReverce))

                    }
                    .frame(height: 100)
                    .addScaleAnimationOnTapGesture(animate: $isAnimate, action: {})
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct ICinemaWalletView_Previews: PreviewProvider {
    static var previews: some View {
        ICinemaWalletView()
    }
}
