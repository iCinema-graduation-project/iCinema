//
//  TicketsView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 15/04/2023.
//

import SwiftUI

struct TicketsView: View {
    
    @State var tickets: [Ticket] = [
    Ticket(image: "posterImage"),
    Ticket(image: "posterImage2"),
    Ticket(image: "posterImage3"),
    Ticket(image: "posterImage"),
    Ticket(image: "posterImage2"),
    Ticket(image: "posterImage3"),
    Ticket(image: "posterImage"),
    Ticket(image: "posterImage2"),
    Ticket(image: "posterImage3")
        ]
    
    var body: some View {
        ICinemaView{
            //            TicketView()
            
            ZStack {
                ForEach(tickets) { ticket in
                    InfiniteStackView(tickets: $tickets, ticket: ticket)
                }
            }
            .padding()
            
         Spacer()
        }
        
    }
}

struct TicketsView_Previews: PreviewProvider {
    static var previews: some View {
        TicketsView()
    }
}

struct InfiniteStackView: View {
    @Binding var tickets: [Ticket]
    var ticket: Ticket
    
    @State var height: CGFloat = 0
    
    @State private var offsetx: CGFloat = .zero
    @GestureState var isDragging: Bool = false
    
    var body: some View {
        VStack {
            TicketView(ticket: ticket, height: height)
        }
        .zIndex(Double(CGFloat(tickets.count) - self.getIndex()))
        .zIndex(getIndex() == 0 && offsetx > 100 ? Double(CGFloat(tickets.count) - self.getIndex()) - 1 : Double(CGFloat(tickets.count) - self.getIndex()))
        // rotate second ticket
        .rotationEffect(getIndex() == 1 ? .degrees(-6) : .degrees(0))
        // rotate third ticket
        .rotationEffect(getIndex() == 2 ? .degrees(6) : .degrees(0))
        
        // will move with an angle because offsetx changes when dragging
        .rotationEffect(Angle(degrees: Double(offsetx * 0.03)))
        // this will scall first ticket to 1 and else to 0.9
        .scaleEffect(getIndex() == 0 ? 1: 0.9)
        
        .offset(x: getIndex() == 1 ? -40 : 0)
        .offset(x: getIndex() == 2 ? 40 : 0)
        .offset(x: offsetx)
        .gesture(
            DragGesture()
                .updating($isDragging, body: { gesture, state, transaction in
                    state = true
                })
                .onChanged({ gesture in
                    var translation = gesture.translation.width
                    translation = tickets.first?.id == ticket.id ? translation : .zero
//                    translation = isDragging ? translation : .zero
                    withAnimation(.easeInOut(duration: 0.3)) {
                        offsetx = translation
                        height = -offsetx / 5
                    }
    
                })
                .onEnded({ gesture in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        let width = UIScreen.main.bounds.width
                        if offsetx > (width / 2){
                            withAnimation {
                                self.removeFirstAndAddToLast()
                            }
                        }else if -offsetx > (width / 2){
                            removeFirst()
                        }
                        offsetx = .zero
                        height = .zero
                        
                    }
                })
        )
    }
    
    func getIndex() -> CGFloat {
        let index = tickets.firstIndex { ticket in
            return self.ticket.id == ticket.id
        } ?? 0
        
        return CGFloat(index)
    }
    
    private func getRotation(angle: Double) -> Double {
        let screenWidth = UIScreen.main.bounds.width
        let progress = offsetx / screenWidth
        
        return Double(progress * angle)
    }
    
    private func removeFirstAndAddToLast() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            guard let first = tickets.first else{return}
            tickets.removeFirst()
            tickets.append(first)
        }
    }
    
    private func removeFirst() {
        tickets.removeFirst()
    }
    
}

