//
//  CinemaChairsView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/03/2023.
//

import SwiftUI

struct CinemaChairsView: View {
    let view: CinemaChairsViewController
    let time: Time
    @Environment(\.colorScheme) var colorScheme
    
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
            VStack(spacing: 10.0){
                Spacer()
                
                Image(uiImage: colorScheme == .dark ? .chairs.arch : UIImage())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(time.seats.indices, id: \.self) { row in
                                HStack {
                                    ForEach(time.seats[row].indices, id: \.self) { colomun in
                                        let seat = time.seats[row][colomun]
                                        Image(uiImage: self.getChair(for: seat))
                                            .frame(width: rowSize, height: rowSize)
//                                            .shadow(radius: value == 3 ? 0 : 1)
                                            .onTapGesture {
//                                                array[co][index] = 3
                                            }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
                .frame(height: 280)
                .padding(.horizontal)
                
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
                .padding(.horizontal, .view.padding.left)
                
                Spacer()
                
                ICinemaButtonView(title: .next) {
                    self.view.coordinator?.push()
                }
                .padding(.bottom, CGFloat.view.padding.bottom)
            }
        }

    }
    
    private func getChair(for seat: Seat) -> UIImage {
        switch seat.status{
        case .empity: return UIImage()
        case .normal: return UIImage.chairs.ordinary
        }
//        if value == 0 {
//            return UIImage.chairs.ordinary
//        } else if value == 1 {
//            return UIImage.chairs.booked
//        } else if value == 2 {
//            return UIImage.chairs.premium
//        } else if value == 3 {
//            return UIImage.chairs.selected
//        } else {
//            return UIImage()
//        }
    }
    
    private func makeChairDescriptionView(value: Int, text: String) -> some View {
        VStack {
            Image(uiImage: UIImage())
                .font(.system(size: rowSize))
                .frame(width: rowSize, height: rowSize)
                .shadow(radius: 1)
            Text(text)
        }
    }
        
}

//struct CinemaChairsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CinemaChairsView()
//    }
//}

