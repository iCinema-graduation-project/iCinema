//
//  PaymentMehodView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 16/04/2023.
//

import SwiftUI

struct PaymentMehodView: View {
    
    @EnvironmentObject var viewModel: PaymentMethodViewModel
    
    var body: some View {
        ICinemaView {
            
            VStack() {
                    
                VStack(alignment: .leading, spacing: 20.0) {
                    Text("Choose a payment method :")
                    
                    HStack(spacing: 20.0) {
                        Image("wallet")
                        
                        VStack(alignment: .leading) {
                            Text("Credit Card")
                                .font(Font(UIFont.footnote))
                            Text("**** **** **** 1425")
                                .font(Font(UIFont.caption1))
                        }
                        
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                    .cornerRadius(8)
                    
                    HStack(spacing: 20.0) {
                        Image("wallet")
                        
                        VStack(alignment: .leading) {
                            Text("Credit Card")
                                .font(Font(UIFont.footnote))
                            Text("**** **** **** 1425")
                                .font(Font(UIFont.caption1))
                        }
                        
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                    .cornerRadius(8)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, CGFloat.view.padding.left)
                .foregroundColor(Color(uiColor: .iCinemaTextColor))

                Spacer()
                
                ICinemaButtonView(title: String.next) {
                    viewModel.dismissAction()
                }
                .padding(.bottom, CGFloat.view.padding.bottom)
            }
          
            .padding(.top, .view.padding.top)
            .foregroundColor(Color(uiColor: .iCinemaTextColor))
            .font(Font(UIFont.title3))

        }
    }
}

struct PaymentMehodView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMehodView()
    }
}
