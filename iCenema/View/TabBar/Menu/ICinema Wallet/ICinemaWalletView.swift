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
            VStack(spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: .view.cornerRadius, style: .continuous)
                        .fill(LinearGradient(colors: [Color(uiColor: .iCinemaYellowColor),
                                                      Color(uiColor: colorScheme == .dark ? .brown : .gray)],
                                             startPoint: .bottomTrailing,
                                             endPoint: .topLeading))
                    VStack {
                        Text("Balance")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.custom.footnote)
                        Text("270 EGP")
                            .font(.custom(fontName, size: 40))
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .foregroundColor(Color(uiColor: .iCinemaTextColorReverce))
                    
                }
                .frame(height: 100)
                .addScaleAnimationOnTapGesture(animate: $isAnimate, action: {})
                .padding(.horizontal, .view.padding.left)
                
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "arrow.down")
                            .font(.custom.title1)
                            .frame(width: 60, height: 60)
                            .background(Color.iCinemaSecondBackgroudColor)
                            .cornerRadius(.view.cornerRadius)
                        Text("Diposit")
                            .font(.custom.body)
                    }
                    
                    Spacer()
                    VStack {
                        Image(systemName: "arrow.up.right")
                            .font(.custom.title1)
                            .frame(width: 60, height: 60)
                            .background(Color.iCinemaSecondBackgroudColor)
                            .cornerRadius(.view.cornerRadius)
                        Text("Withdrawal")
                            .font(.custom.body)
                    }
                    Spacer()

                }
                
                ScrollableSectionView(title: "Activity",
                                      hasDivider: false,
                                      axis: .vertical,
                                      scrollable: true) {
                    VStack(spacing: 20.0) {
                        HStack {
                            Image(systemName: "arrow.down")
                                .foregroundColor(.iCinemaYellowColor)
                            Text("100 EGP")

                        }
                        .font(.custom.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.iCinemaSecondBackgroudColor)
                        .cornerRadius(10)
                    
                        HStack {
                            Image(systemName: "arrow.up.right")
                                .foregroundColor(.red)
                            Text("80 EGP")

                        }
                        .font(.custom.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.iCinemaSecondBackgroudColor)
                        .cornerRadius(10)
                        HStack {
                            Image(systemName: "arrow.down")
                                .foregroundColor(.iCinemaYellowColor)
                            Text("200 EGP")

                        }
                        .font(.custom.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.iCinemaSecondBackgroudColor)
                        .cornerRadius(10)
                        HStack {
                            Image(systemName: "arrow.down")
                                .foregroundColor(.iCinemaYellowColor)
                            Text("50 EGP")

                        }
                        .font(.custom.footnote)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.iCinemaSecondBackgroudColor)
                        .cornerRadius(10)
                    
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)

                }
                .frame(maxHeight: .infinity, alignment: .top)
                
            }
            
        }
    }
}

struct ICinemaWalletView_Previews: PreviewProvider {
    static var previews: some View {
        ICinemaWalletView()
    }
}
