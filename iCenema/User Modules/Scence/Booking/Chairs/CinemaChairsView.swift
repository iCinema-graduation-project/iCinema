//
//  CinemaChairsView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/03/2023.
//

import SwiftUI

class CinemaChairesViewModel: ObservableObject{
    @Published var selectedSeats: [Seat] = []
    @Published var count: Int = 0
}

struct CinemaChairsView: View {
    let view: CinemaChairsViewController
    var time: Time
    @Environment(\.colorScheme) var colorScheme
    
    @ObservedObject var viewModel = CinemaChairesViewModel()
    
    let rowSize: CGFloat = 25
        
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
                                        var seat = time.seats[row][colomun]
                                        Image(uiImage: !viewModel.selectedSeats.contains(seat) ? self.getChair(for: seat) : UIImage.chairs.selected)
                                            .frame(width: rowSize, height: rowSize)
                                        // .shadow(radius: value == 3 ? 0 : 1)
                                            .onTapGesture {
                                                if viewModel.selectedSeats.contains(seat) {
                                                    viewModel.selectedSeats.removeAll { $0 == seat }
                                                    viewModel.count -= seat.price ?? 0
                                                    
                                                } else {
                                                    viewModel.selectedSeats.append(seat)
                                                    viewModel.count += seat.price ?? 0
                                                    print(viewModel.selectedSeats)
                                                }
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
                        self.makeChairDescriptionView(status: .normal, text: "Ordinary")
                        Spacer()
                        self.makeChairDescriptionView(status: .premium, text: "Premium")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        self.makeChairDescriptionView(status: .reserved, text: "Booked")
                        Spacer()
                        self.makeChairDescriptionView(status: .selected, text: "Selected")
                        Spacer()
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Your tickets :")
                    
                    Text("\(viewModel.selectedSeats.count) ordinary seats, \(viewModel.count) EGP for ticket")
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                .cornerRadius(.view.cornerRadius)
                .padding(.horizontal, .view.padding.left)
                
                Spacer()
                
                ICinemaButtonView(title: .next) {
                    let seatsId = viewModel.selectedSeats.map { $0.id }
                    print(seatsId)
                    self.view.coordinator?.push(userInfo: ["timeId": time.id, "seatsId": seatsId])
                }
                .padding(.bottom, CGFloat.view.padding.bottom)
            }
        }
    }
    
    private func getChair(for seat: Seat) -> UIImage {
        switch seat.status{
        case .empity: return UIImage()
        case .normal: return UIImage.chairs.ordinary
        case .premium: return UIImage.chairs.premium
        case .reserved: return UIImage.chairs.booked
        case .selected: return UIImage.chairs.selected
        }
    }
    
    private func makeChairDescriptionView(status: SeatStatus, text: String) -> some View {
        VStack {
            Image(uiImage: getChair(for: Seat(id: 0, status: status, price: nil)))
                .font(.system(size: rowSize))
                .frame(width: rowSize, height: rowSize)
                .shadow(radius: 1)
            Text(text)
        }
    }
        
}

