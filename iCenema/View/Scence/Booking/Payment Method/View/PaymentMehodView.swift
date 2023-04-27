//
//  PaymentMehodView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 16/04/2023.
//

import SwiftUI

enum PaymentMethod {
    case creditCard
    case eWallet
    case iCinemaWallet
    case none
}


struct PaymentMehodView: View {
    
    @EnvironmentObject var viewModel: PaymentMethodViewModel
    
    @State private var showCreditCardview: Bool = false
    @State private var showEWallet: Bool = false
    
    var body: some View {
        ICinemaView {
            ZStack(alignment: .center) {
                
                VStack() {
                    
                    VStack(alignment: .leading, spacing: 20.0) {
                        Text(String.booking.pickApayment)
                            .font(Font(UIFont.title3))
                        
                        cell(image: .payment.creditCard,
                             title: .booking.creditCard,
                             subtitle: "**** **** **** 1425",
                             selected: $viewModel.isCreditCard
                        )
                        .onTapGesture {
                            withAnimation {
                                showCreditCardview = true
                            }
                        }
                        
                        cell(image: .payment.eWallet,
                             title: .booking.eWallet,
                             subtitle: "Vodafone Cash, Etisalat, etc"
                             , selected: $viewModel.isEWallet)
                        .onTapGesture {
                            withAnimation {
                                showEWallet = true
                            }
                        }
                        cell(image: .payment.iCinemaWallet,
                             title: .booking.icinemaWallet,
                             subtitle: "Current balance : 0 EGP",
                             selected: $viewModel.isICinemaWallet)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, CGFloat.view.padding.left)
                    .foregroundColor(Color(uiColor: .iCinemaTextColor))
                    
                    Spacer()
                    
                    ICinemaButtonView(title: String.next) {
                        if viewModel.paymentMethod != .none {
                            viewModel.dismissAction()
                        }
                        
                    }
                    .padding(.bottom, CGFloat.view.padding.bottom)
                }
                .padding(.top, .view.padding.top)
                .foregroundColor(Color(uiColor: .iCinemaTextColor))
                
                
                if showCreditCardview {
                    CreditCardView(showCreditCardview: $showCreditCardview)
                   
                }
                        
                if showEWallet {
                    EWalletView(showEWallet: $showEWallet)
                }
                  
                }
            }
            
        }
    }
    
    

    
    @ViewBuilder
    private func cell(image: UIImage, title: String, subtitle: String, selected: Binding<Bool>) -> some View {
        HStack(spacing: 20.0) {
            Image(uiImage: image)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(Font(UIFont.footnote))
                Text(subtitle)
                    .font(Font(UIFont.caption1))
            }
            
            Toggle("", isOn: selected)
                .tint(Color(uiColor: .iCinemaYellowColor))
            
            
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(uiColor: .iCinemaSecondBackgroudColor))
        .cornerRadius(8)
    }


struct PaymentMehodView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMehodView()
            .environmentObject(PaymentMethodViewModel())
    }
}
