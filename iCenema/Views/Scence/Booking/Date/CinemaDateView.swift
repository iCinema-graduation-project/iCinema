//
//  CinemaDateView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/03/2023.
//

import SwiftUI

struct CinemaDateView: View {
    @State private var date = Date()
    @Environment(\.colorScheme) var colorScheme

//    @State private var times = [ ]
    enum Flavor: String, CaseIterable, Identifiable {
        case chocolate, vanilla, strawberry
        var id: Self { self }
    }

    @State private var selectedFlavor: Flavor = .chocolate

    @EnvironmentObject var viewModel: CinemaDateViewModel
    
    var body: some View {
        ICinemaView {
            VStack {
                VStack(alignment: .leading){
                    Text("pick a day: ")
                        .foregroundColor(Color(uiColor: .iCinemaTextColor))
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .accentColor(Color(uiColor: .iCinemaYellowColor))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: .view.cornerRadius)
                                .fill(Color(uiColor: .iCinemaSecondBackgroudColor))
//                                .opacity(0.1)
                                .shadow(radius: 1, x: 4, y: 4)
                        )
                        .labelsHidden()

                  
                }
                .padding(.horizontal, .view.spacing)

                VStack(alignment: .leading) {
                    Text("pick a time: ")
                        .foregroundColor(Color(uiColor: .iCinemaTextColor))
                    
                    Picker("", selection: $selectedFlavor) {
                        Text("6:00").tag(Flavor.chocolate)
                        Text("5:00").tag(Flavor.vanilla)
                        Text("4:00").tag(Flavor.strawberry)
                    }
                    .accentColor(Color(uiColor: .iCinemaTextColor))
                    .frame(maxWidth: .infinity)
                    .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                    .cornerRadius(8)

                }
                .padding(.horizontal, .view.spacing)


                Spacer()
                
                ICinemaButtonView(title: "Next") {
                    self.viewModel.buttonAction?()
                }
                .padding(.bottom, CGFloat.view.spacing)

             
            }
        }
    }
}

struct CinemaDateView_Previews: PreviewProvider {
    static var previews: some View {
        CinemaDateView()
    }
}
