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
                Spacer()
                VStack(alignment: .leading) {
                    Text("pick a hall: ")
                        .padding(.horizontal, CGFloat.view.spacing)
                        .font(Font(UIFont.callout))

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            HallView()
                            HallView()
                        }
                    }
                    
                }
                .padding(.vertical, CGFloat.view.spacing)

                
                Spacer()
    
                ICinemaButtonView(title: "Next") {
                    self.viewModel.buttonAction?()
                }
                .padding(.bottom, CGFloat.view.spacing)
                
            }
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
        RoundedRectangle(cornerRadius: CGFloat.view.cornerRadius)
            .stroke(Color(uiColor: .iCinemaYellowColor), lineWidth: 0.5)
            .frame(width: 265, height: 238)
            .offset(y: 1)
            .overlay {
                VStack {
                    VStack(alignment: .leading) {
                        Image("hale")
                            .resizable()
                            .frame(height: 145)
                            .cornerRadius(.view.cornerRadius)
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Hall 1")
                                .font(Font(UIFont.callout))
                            
                            Text("This hall is the biggest in our cinema and it can accommodate 400 people.")
                                .font(Font(UIFont.caption1))
                        }
                        Spacer()
                    }
                    .padding(.cell.padding.left)
                    
                }
                .frame(width: 265, height: 238)
                .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                .cornerRadius(.view.cornerRadius)
                
                
            }
            .padding(.leading, CGFloat.view.spacing)
            .padding(.bottom, CGFloat.view.spacing)
            .foregroundColor(Color(uiColor: .iCinemaTextColor))
    }
}
