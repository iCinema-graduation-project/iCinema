//
//  CreditCardView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 17/04/2023.
//

import SwiftUI

struct CreditCardView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var cardNumber: String = ""
    @State private var cardHoldreName: String = ""
    @State private var cvvCode: String = ""
    @State private var expireDate: String = ""
    
    @Binding var showCreditCardview: Bool
    
    var body: some View {
        
        
        VStack(alignment: .trailing, spacing: 0.0) {
            Button {
                withAnimation {
                    showCreditCardview = false
                }
            } label: {
                Image(systemName: "x.circle")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.trailing)
                    .foregroundColor(Color(uiColor: .iCinemaYellowColor))
            }
            
            CardView()
                .padding()

            ICinemaButtonView(title: .saveEdits, type: .small) {
                withAnimation {
                    showCreditCardview = false
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .offset(y: -50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThickMaterial.opacity(0.08))
        .transition(.move(edge: .bottom))

       
        
    }
    
    @ViewBuilder
    func CardView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(LinearGradient(colors: [Color(uiColor: .iCinemaYellowColor),
                                              Color(uiColor: colorScheme == .dark ? .brown : .gray)],
                                     startPoint: .bottomTrailing,
                                     endPoint: .topLeading))
            
            // Card Detail
            VStack(spacing: 10.0) {
                HStack {
                    TextField("XXXX XXXX XXXX XXXX", text: .init(get: {
                        cardNumber
                    }, set: { value in
                        cardNumber = ""
                        
//                        // Inserting Space For Every 4 Digits
                        let startIndex = value.startIndex
                        for index in 0..<value.count {
                            let stringIndex = value.index(startIndex, offsetBy: index)
                            cardNumber += String(value[stringIndex])

                            if (index + 1) % 5 == 0 && value[stringIndex] != " " {
                                cardNumber.insert(" ", at: stringIndex)
                            }
                        }
                        // Removing Empty Space When Going Back
                        if value.last == " " {
                            /// Limiting To 16 Digits
                            // Including with 3 Spaces (16 + 3 = 19)
                            cardNumber.removeLast()
                        }
                        
                        cardNumber = String(cardNumber.prefix (19))
                       

                    }))
                                            
                        .font(Font(UIFont.title3))
                        .keyboardType(.numberPad)

                    Spacer(minLength: 0)
                    
                    Image(uiImage: .payment.visa)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                }
                
                HStack {
                    TextField("MM/YY", text: .init(get: {
                        expireDate
                    }, set: { value in
                        expireDate = value
                        // Inserting a slash in the third string position to differentiate between month and year
                        if value.count == 3 && !value.contains ("/") {
                            let startIndex = value.startIndex
                            let thirdPosition = value.index(startIndex, offsetBy: 2)
                            expireDate.insert("/", at: thirdPosition)
                        }
                        /// Same As before, Removing / When Going back
                        if value.last == "/" {
                            expireDate.removeLast ()
                        }
                            /// Limiting String
                            // Included with one Slash (4 + 1 = 5)
                            expireDate = String(expireDate.prefix(5))
                        
                    }))
                        .keyboardType(.numberPad)

                    Spacer(minLength: 0)

                    TextField("CVV", text: .init(get: {
                        cvvCode
                    }, set: { value in
                        cvvCode = value
                        cvvCode = String(cvvCode.prefix(3))
                    }))
                        .keyboardType(.numberPad)
                        .frame(width: 35)
                    
                    Image(systemName: "questionmark.circle.fill")
//                        .foregroundColor(Color.white)
                }
                .padding(.top, 15)
                
                Spacer()
                
                TextField("CARD HOLDER NAME", text: $cardHoldreName)
                
            }
            .padding(20)
            .environment(\.colorScheme, .dark)
        }
        .frame(height: 200)
//        .padding(.top, 35)
    }
}

struct CreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreditCardView( showCreditCardview: .constant(false))
    }
}
