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
            
            ZStack(alignment: .bottom) {
                VStack(spacing: 0.0) {
                    TicketTopView(ticket: ticket)
                    Spacer(minLength: height)
                    TicketBottomView(ticket: ticket)
                    
                }
                // Qr Code
//                Image("code")
//                    .resizable()
//                    .frame(width: qrWidth, height: qrHeight)
//                    .padding(.bottom)
//                    .offset(y: qrYPosition)
//                    .glow(color: Color(uiColor: .iCinemaYellowColor), radius: qrShadowRadius)
//                    .onTapGesture {
//                        withAnimation {
//                            if qrWidth == 50 {
//                                qrWidth = 150
//                                qrHeight = 150
//                                qrYPosition = -40
//                                qrShadowRadius = 3
//                            } else {
//                                qrWidth = 50
//                                qrHeight = 50
//                                qrYPosition = 0
//                                qrShadowRadius = 1
//                            }
//                        }
//                    }
                
            }
            .frame(height: 460)
            .font(Font(UIFont.callout))
            .glow(color: Color(uiColor: .iCinemaYellowColor), radius: 1)
    }
}

//struct TicketView_Previews: PreviewProvider {
//    static var previews: some View {
//        TicketView(ticket: Ticket(image: "SliderImage"), height: 0)
//    }
//}

struct TicketTopView: View {
    var ticket: Ticket
    
    var body: some View {
            
            VStack(spacing: 4.0) {

            }
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
            .frame(width: 250, height: 325, alignment: .top)
            .foregroundColor(Color(uiColor: .iCinemaYellowColor))
            .background(
                ICinemaAsyncImage(url: URL(string: ticket.movie.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
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
                                           endPoint: .bottomTrailing), lineWidth: 3)
            }
            
            .cornerRadius(40, corners: [.topLeft, .topRight])
        
    }
}

struct TicketBottomView: View {
    var ticket: Ticket
    let dateFormatter = DateFormatter()
    
    @State private var month: String = ""
    @State private var day: Int = 0
    @State private var time: String = ""
    @State private var seats: String = ""
    
    init(ticket: Ticket) {
        self.ticket = ticket
        
        dateFormatter.dateFormat = "MMMM d yyyy h:mm a"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    }
    
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
                    Text("\(month) \(day)")
                }
                HStack(spacing: 4.0) {
                    Text("Time:")
                        .fontWeight(.medium)
                        .foregroundColor(Color(uiColor: .iCinemaTextColor))
                    Text("\(time)")
                }
            }
            .foregroundColor(Color(uiColor: .iCinemaYellowColor))
            
            
            HStack(spacing: 20.0) {
//                HStack(spacing: 4.0) {
//                    Text("Row:")
//                        .fontWeight(.medium)
//                        .foregroundColor(Color(uiColor: .iCinemaTextColor))
//                    Text("2")
//                }
                HStack(spacing: 4.0) {
                    Text("Seats:")
                        .fontWeight(.medium)
                        .foregroundColor(Color(uiColor: .iCinemaTextColor))
                    Text("\(seats)")
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
        .onAppear {
            self.updateDate()
            seats = ""
            ticket.seats.forEach { seats += "\($0.name), " }
        }
    }
    
    
    private func updateDate() {
        if let date = dateFormatter.date(from: ticket.start) {
            self.updateMonth(from: date)
            self.updateDay(from: date)
            self.updateTime(from: date)
        } else {
            print("error")
        }
        
    }
    
    private func updateMonth(from date: Date) {
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"
        month = monthFormatter.string(from: date)
    }
    private func updateDay(from date: Date) {
        let calendar = Calendar.current
        day = calendar.component(.day, from: date)
    }
    private func updateTime(from date: Date) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h:mm a"
        time = timeFormatter.string(from: date)
    }
}
