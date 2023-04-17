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
                    Text(String.booking.pickApayment)
                        .font(Font(UIFont.title3))
                    
                    cell(image: .payment.creditCard,
                         title: .booking.creditCard,
                         subtitle: "**** **** **** 1425")
                    
                    cell(image: .payment.eWallet,
                         title: .booking.eWallet,
                         subtitle: "Vodafone Cash, Etisalat, etc")
                    
                    cell(image: .payment.iCinemaWallet,
                         title: .booking.icinemaWallet,
                         subtitle: "Current balance : 0 EGP")
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

        }
        
        
    }
    
    @ViewBuilder
    private func cell(image: UIImage, title: String, subtitle: String) -> some View {
        HStack(spacing: 20.0) {
            Image(uiImage: image)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(Font(UIFont.footnote))
                Text(subtitle)
                    .font(Font(UIFont.caption1))
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(uiColor: .iCinemaSecondBackgroudColor))
        .cornerRadius(8)
    }
}

struct PaymentMehodView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMehodView()
    }
}
