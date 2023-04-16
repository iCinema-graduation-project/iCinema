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
            VStack(spacing: CGFloat.view.spacing) {
                VStack(alignment: .leading){
                    Text(String.booking.pickADay)
                    
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .accentColor(Color(uiColor: .iCinemaYellowColor))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: .view.cornerRadius)
                                .fill(Color(uiColor: .iCinemaSecondBackgroudColor))
                                .opacity(0.5)
                                .shadow(radius: 1, x: 4, y: 4)
                        )
                        .labelsHidden()
                    
                }

                VStack(alignment: .leading) {
                    Text(String.booking.pickATime)
                    
                    Picker("", selection: $selectedFlavor) {
                        Text("6:00").tag(Flavor.chocolate)
                        Text("5:00").tag(Flavor.vanilla)
                        Text("4:00").tag(Flavor.strawberry)
                    }
                    .accentColor(Color(uiColor: .iCinemaTextColor))
                    .frame(maxWidth: .infinity)
                    .frame(height: .iCinemaButton.size.height)
                    .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                    .cornerRadius(.iCinemaButton.cornerRadius)

                }

                Spacer()
                
                ICinemaButtonView(title: String.next) {
                    self.viewModel.dismissAction()
                }
                .padding(.bottom, CGFloat.view.padding.bottom)
                
            }
            .padding(.top, .view.padding.top)

            .padding(.leading, .view.padding.left)
            .padding(.trailing, .view.padding.right)
        
            .foregroundColor(Color(uiColor: .iCinemaTextColor))
            .font(Font(UIFont.title3))


        }
    }
}

struct CinemaDateView_Previews: PreviewProvider {
    static var previews: some View {
        CinemaDateView()
    }
}
