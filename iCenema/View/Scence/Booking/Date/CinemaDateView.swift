//
//  CinemaDateView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/03/2023.
//

import SwiftUI
import SPAlert

struct CinemaDateView: View {
    let view: CinemaDateViewController
//    let dates: [BookingDate]
    
    @State private var selectedDate: BookingDate = .init(id: -1, isoDate: "", times: []) {
        didSet {
            selectedTime = .init(id: -1, premiumPrice: nil, price: nil, time: "", seats: [])
        }
    }
    @State private var selectedTime: Time = .init(id: -1, premiumPrice: nil, price: nil, time: "", seats: [])
    
    
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    var body: some View {
        ICinemaView {
            VStack(spacing: CGFloat.view.spacing) {
                VStack(alignment: .leading){
                    Text(String.booking.pickADay)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 15) {
                            ForEach(view.viewModel.dates, id: \.id) { date in
                                HStack {
                                    Text("\(date.isoDate)")
                                    Spacer()
                                    if selectedDate.id == date.id {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.iCinemaYellowColor)
                                    }
                                }
                                .frame(height: 44)
                                .padding(.horizontal)
                                .background(Color.iCinemaSecondBackgroudColor)
                                .cornerRadius(.view.cornerRadius)
                                .onTapGesture {
                                    selectedDate = date
                                }
                            }
                        }
                    }
                }
                
                VStack(alignment: .leading){
                    Text(String.booking.pickATime)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 15) {
                            ForEach(selectedDate.times, id: \.id) { time in
                                HStack {
                                    Text("\(time.time)")
                                    Spacer()
                                    if selectedTime.id == time.id {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.iCinemaYellowColor)
                                    }
                                }
                                .frame(height: 44)
                                .padding(.horizontal)
                                .background(Color.iCinemaSecondBackgroudColor)
                                .cornerRadius(.view.cornerRadius)
                                .onTapGesture {
                                    selectedTime = time
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                ICinemaButtonView(title: String.next) {
                    if self.selectedDate.id == -1 || self.selectedTime.id == -1 {
                        self.alertMessage = "select time to contineue"
                        showAlert = true
                    } else {
                        self.view.coordinator?.push(userInfo: ["time": selectedTime])
                    }
                }
                .padding(.bottom, CGFloat.view.padding.bottom)
                
            }
            .SPAlert(isPresent: $showAlert, message: alertMessage)
            .padding(.top, .view.padding.top)
            .padding(.leading, .view.padding.left)
            .padding(.trailing, .view.padding.right)
            .foregroundColor(Color(uiColor: .iCinemaTextColor))
            .font(Font(UIFont.title3))
            .onAppear {
                guard let first = self.view.viewModel.dates.first else { return }
                self.selectedDate = first
            }
        }
     
    }
}

struct CinemaDateView_Previews: PreviewProvider {
    static var previews: some View {
      
        CinemaDateView(view: CinemaDateViewController())
    }
}
