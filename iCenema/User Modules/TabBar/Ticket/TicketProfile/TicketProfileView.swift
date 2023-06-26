//
//  TicketProfileView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/06/2023.
//

import SwiftUI
import UIICinema
struct TicketProfileView: View {
    @EnvironmentObject var viewModel: TicketProfileViewModel
    
    @State var categories: String = ""
    @State var seats: String = ""
    
    var body: some View {
        ProfileView(profileViewDelegate: viewModel, imageUrl: viewModel.ticket.movie.image, ingnoreSaveArea: .all) {
            VStack {
                AsyncImage(url: URL(string: viewModel.ticket.movie.image)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .blur(radius: 60) // <- this is the important modifier. The rest is just for demo
                    
                } placeholder: {
                    Color.gray
                }
                
            }
            .overlay {
                VStack {
                    Spacer()
                    VStack {
                        
                    }
                    .frame(height: 400)
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.5))
                    .blur(radius: 30)
                    .cornerRadius(20)
                    .overlay {
                        VStack(spacing: 10) {
                            HStack(alignment: .top, spacing: 20) {
                                ICinemaAsyncImage(url: URL(string: viewModel.ticket.movie.image)) { image in
                                    image
                                        .resizable()
                                        .addBorder(withColor: Color(uiColor: .iCinemaYellowColor),
                                                   cornorRadius: 8, height: 110)
                                        .frame(width: 80)
                                }
                                VStack(alignment: .leading) {
                                    Text(viewModel.ticket.movie.name)
                                        .font(Font(UIFont.footnote))
                                        .lineLimit(1)
                                    HStack {
                                        self.text("\(viewModel.ticket.movie.releaseDate ?? "")")
                                        self.text("\(viewModel.ticket.movie.timeInMinutes ?? 0) M")
                                        self.text("\(viewModel.ticket.movie.minAge ?? 0)+")
                                    }
                                    Text(categories)
                                        .font(Font(UIFont.caption1))
                                        .foregroundColor(Color(uiColor: .lightGray))
                                        .lineLimit(2)
                                    
                                    Spacer()
                                    Text(viewModel.ticket.startsAfter)
                                        .font(Font(UIFont.callout))
                                        .foregroundColor(Color(uiColor: .lightGray))
                                }
                                Spacer()
                            }
                            .frame(height: 109)
                            
                            row("CINEMA", value: viewModel.ticket.movie.cinema.name ?? "")
                            row("START", value: viewModel.ticket.start)
                            row("END", value: viewModel.ticket.end)
                            row("SEATS", value: seats)
                            Divider()
                                .background(Color(uiColor: .lightGray))
                            Image("code")
                                .resizable()
                                .frame(width: 120, height: 120)
                                .padding(.bottom)
                                .glow(color: Color(uiColor: .iCinemaYellowColor), radius: 5)
                        }
                        .padding()
                    }
                    .padding(30)
                }
            }
        }
        .onAppear {
            withAnimation {
                viewModel.ticket.movie.categories?.forEach { categories += "\($0.name), " }
                viewModel.ticket.seats.forEach { seats += "\($0.name), " }
            }
        }
    }
    
    private func text(_ string: String) -> some View {
        Text(string)
            .font(Font(UIFont.caption1))
            .padding(.horizontal)
            .frame(height: 18)
            .background(Color(uiColor: .iCinemaYellowColor))
            .foregroundColor(Color(uiColor: .iCinemaTextColorReverce))
            .cornerRadius(4)
    }
    
    private func row(_ string: String, value: String) -> some View {
        HStack {
            Text(string)
                .font(Font(UIFont.callout))
                .foregroundColor(Color(uiColor: .lightGray))
            Spacer()
            Text(value)
                .font(Font(UIFont.callout))
                .lineLimit(1)
        }
    }
}

struct TicketProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TicketProfileView()
    }
}
