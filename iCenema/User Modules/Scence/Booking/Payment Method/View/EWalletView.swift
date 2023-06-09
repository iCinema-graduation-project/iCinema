//
//  EWalletView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 17/04/2023.
//

import SwiftUI

struct EWalletView: View {
    
    @Binding var showEWallet: Bool
    
    @State var walletNumber: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(alignment: .trailing) {
            Button {
                withAnimation {
                    showEWallet = false
                }
            } label: {
                Image(systemName: "x.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.trailing)
                    .foregroundColor(Color(uiColor: .iCinemaYellowColor))
            }
            .padding(.bottom)
            
            ICinemaAlertView(height: 260) {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Wallet Number")
                        TextField("0100000000", text: $walletNumber)
                            .padding()
                            .frame(height: 44)
                            .background(Color(uiColor: .iCinemaBackgroundColor))
                            .cornerRadius(8)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Password")
                        SecureField("********", text: $password)
                            .padding()
                            .frame(height: 44)
                            .background(Color(uiColor: .iCinemaBackgroundColor))
                            .cornerRadius(8)
                    }
                    Spacer()
                    Text("360 EGP will be deducted from your wallet ")
                        .font(Font(UIFont.callout))
                    
                }
                .font(Font(UIFont.footnote))
                .padding()
                
                ICinemaButtonView(title: .saveEdits, type: .small) {
                    withAnimation {
                        showEWallet = false
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom)
            }
            
        }
        .offset(y: -50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThickMaterial.opacity(0.08))
        .transition(.move(edge: .bottom))
    }
}

struct EWalletView_Previews: PreviewProvider {
    static var previews: some View {
        EWalletView(showEWallet: .constant(false))
    }
}
