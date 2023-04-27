//
//  TicketView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 15/04/2023.
//

import SwiftUI

struct TicketView: View {
    let ticket: Ticket
    var height: CGFloat
    
    @State private var qrWidth: CGFloat = 50
    @State private var qrHeight: CGFloat = 50
    @State private var qrYPosition: CGFloat = 0
    @State private var qrShadowRadius: CGFloat = 1
    
    var body: some View {
//        ICinemaView {
            
            ZStack(alignment: .bottom) {
                VStack(spacing: 0.0) {
                    TicketTopView(ticket: ticket)
                    Spacer(minLength: height)
                    TicketBottomView()
                    
                }
                // Qr Code
                Image("code")
                    .resizable()
                    .frame(width: qrWidth, height: qrHeight)
                    .padding(.bottom)
                    .offset(y: qrYPosition)
                    .glow(color: Color(uiColor: .iCinemaYellowColor), radius: qrShadowRadius)
                    .onTapGesture {
                        withAnimation {
                            if qrWidth == 50 {
                                qrWidth = 150
                                qrHeight = 150
                                qrYPosition = -40
                                qrShadowRadius = 3
                            } else {
                                qrWidth = 50
                                qrHeight = 50
                                qrYPosition = 0
                                qrShadowRadius = 1
                            }
                        }
                    }
                
            }
            .frame(height: 460)
            .font(Font(UIFont.callout))
            .glow(color: Color(uiColor: .iCinemaYellowColor), radius: 1)

//        }
    }
}

struct TicketView_Previews: PreviewProvider {
    static var previews: some View {
        TicketView(ticket: Ticket(image: "posterImage"), height: 0)
    }
}

struct TicketTopView: View {
    @State var ticket: Ticket
    var body: some View {
            
            VStack(spacing: 4.0) {

            }
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
            .frame(width: 250, height: 325, alignment: .top)
            .foregroundColor(Color(uiColor: .iCinemaYellowColor))
            .background(
                Image(ticket.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            )
            .mask {
                Image("thor-top")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(
                        LinearGradient(colors: [Color(uiColor: .iCinemaYellowColor),
                                                Color(uiColor: .iCinemaYellowColor).opacity(0),
                                                Color(uiColor: .iCinemaYellowColor).opacity(0)
                                               ],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing),
                            lineWidth: 3)
                
            }
            
            .cornerRadius(40, corners: [.topLeft, .topRight])
        
    }
}

struct TicketBottomView: View {

    var body: some View {
        VStack(spacing: 10.0) {
            Line()
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [7]))
                .frame(width: 200, height: 1)
                .opacity(0.6)

            HStack(spacing: 20.0) {
                HStack(spacing: 4.0) {
                    Text("Date:")
                        .fontWeight(.medium)
                        .foregroundColor(Color(uiColor: .iCinemaTextColor))
                    Text("April 23")
                }
                HStack(spacing: 4.0) {
                    Text("Time:")
                        .fontWeight(.medium)
                        .foregroundColor(Color(uiColor: .iCinemaTextColor))
                    Text("6 p.m.")
                }
            }
            .foregroundColor(Color(uiColor: .iCinemaYellowColor))


            HStack(spacing: 20.0) {
                HStack(spacing: 4.0) {
                    Text("Row:")
                        .fontWeight(.medium)
                        .foregroundColor(Color(uiColor: .iCinemaTextColor))
                    Text("2")
                }
                HStack(spacing: 4.0) {
                    Text("Seats:")
                        .fontWeight(.medium)
                        .foregroundColor(Color(uiColor: .iCinemaTextColor))
                    Text("9, 10")
                }
            }
            .foregroundColor(Color(uiColor: .iCinemaYellowColor))


        }
        .frame(width: 250, height: 135, alignment: .top)
        .background(
            Color(uiColor: .iCinemaSecondBackgroudColor)
        )
        .mask {
            Image("thor-bottom")
        }

    }
}
