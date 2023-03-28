//
//  CinemaChairsView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/03/2023.
//

import SwiftUI


struct CinemaChairsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var viewModel: CinemaChairsViewModel
    
    let rowSize: CGFloat = 25
    
    @State var array = [
        [-1, 2, 2, 2, 2, -1, 2, 2, 2, 2, -1],
        [0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, -1, 0, 0, 1, 1, 0],
        [0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0],
        [0, 0, 1, 1, 1, -1, 1, 1, 0, 0, 0],
        [0, 0, 0, 0, 0, -1, 0, 0, 1, 1, 1],
        [0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0],
    ]
    
    var body: some View {
        ICinemaView {
            VStack(spacing: 20.0){
                Spacer()
                
                Image(uiImage: colorScheme == .dark ? .chairs.arch : UIImage())
                    .shadow(radius: 5)
                
                ScrollView(.horizontal, showsIndicators: true) {
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack {
                            ForEach(array.indices, id: \.self) { list in
                                HStack {
                                    ForEach(array[list].indices, id: \.self) { index in
                                        let value = array[list][index]
                                        Image(uiImage: self.getChair(for: value))
                                            .frame(width: rowSize, height: rowSize)
                                            .shadow(radius: value == 3 ? 0 : 1)
                                            .onTapGesture {
                                                array[list][index] = 3
                                            }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                        .frame(height: 300)
                
                VStack {
                    HStack {
                        Spacer()
                        self.makeChairDescriptionView(value: 0, text: "Ordinary")
                        Spacer()
                        self.makeChairDescriptionView(value: 2, text: "Premium")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        self.makeChairDescriptionView(value: 1, text: "Booked")
                        Spacer()
                        self.makeChairDescriptionView(value: 3, text: "Selected")
                        Spacer()
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Your tickets :")
                    Text("4 ordinary seats, 90 EGP for ticket")
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                .cornerRadius(.view.cornerRadius)
                .padding(.horizontal, .view.spacing)
                
                ICinemaButtonView(title: "Next") {
                    self.viewModel.buttonAction?()
                }
                .padding(.bottom, CGFloat.view.spacing)
            }
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color(uiColor: .iCinemaBackgroundColor))
//
    }
    
    private func getChair(for value: Int) -> UIImage {
        if value == 0 {
            return UIImage.chairs.ordinary
        } else if value == 1 {
            return UIImage.chairs.booked
        } else if value == 2 {
            return UIImage.chairs.premium
        } else if value == 3 {
            return UIImage.chairs.selected
        } else {
            return UIImage()
        }
    }
    
    private func makeChairDescriptionView(value: Int, text: String) -> some View {
        VStack {
            Image(uiImage: self.getChair(for: value))
                .font(.system(size: rowSize))
                .frame(width: rowSize, height: rowSize)
                .shadow(radius: 1)
            Text(text)
        }
    }
        
}

struct CinemaChairsView_Previews: PreviewProvider {
    static var previews: some View {
        CinemaChairsView()
    }
}

