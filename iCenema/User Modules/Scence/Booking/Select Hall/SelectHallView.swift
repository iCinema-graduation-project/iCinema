//
//  SelectHallView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/03/2023.
//

import SwiftUI

struct SelectHallView: View {
    
    @EnvironmentObject var viewModel: SelectHallViewModel
    
    var body: some View {
        ICinemaView {
            VStack {
                
                VStack(alignment: .leading) {
                    Text(String.booking.pickAHall)
                        .padding(.horizontal, CGFloat.view.padding.left)
                        .font(Font(UIFont.title3))

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0){
                            ForEach(0..<5, id: \.self) { _ in
                                HallView()
                                    .padding(.horizontal, CGFloat.cell.padding.left)
                            }
                   
                        }
                        .padding(.horizontal, CGFloat.view.padding.left)

                    }
                    
                }

                Spacer()
    
                ICinemaButtonView(title: .next) {
                    self.viewModel.dismissAction()
                }
                .padding(.bottom, CGFloat.view.padding.bottom)
                
            }
            .foregroundColor(Color(uiColor: .iCinemaTextColor))
            .padding(.top, CGFloat.view.padding.top)

            

        }
    }
}

struct SelectHallView_Previews: PreviewProvider {
    static var previews: some View {
        SelectHallView()
    }
}


struct HallView: View {
    var body: some View {

        VStack {
            VStack(alignment: .leading) {
                Image("hale")
                    .resizable()
                    .frame(height: 145)
                    .cornerRadius(.view.cornerRadius)

                VStack(alignment: .leading, spacing: 5) {
                    Text("Hall 1")
                        .font(Font(UIFont.footnote))
                    
                    Text("This hall is the biggest in our cinema and it can accommodate 400 people.")
                        .font(Font(UIFont.body))
                }
                Spacer()
            }
            .padding(.cell.padding.left)
            
        }
        .frame(width: 265, height: 283)
        .background(Color(uiColor: .iCinemaSecondBackgroudColor))
        .cornerRadius(.view.cornerRadius)
        .addBorder(withColor: Color(uiColor: .iCinemaYellowColor), height: 285)
        .foregroundColor(Color(uiColor: .iCinemaTextColor))
        
    }
}
