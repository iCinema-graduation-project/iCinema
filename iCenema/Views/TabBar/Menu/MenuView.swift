//
//  MenuView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/03/2023.
//

import SwiftUI

struct MenuView: View {
    
    var body: some View {
            List {
                menuSection {
                    HStack(spacing: 15.0) {
                        Image("profile")
                            .makeCircled(size: CGSize(width: 40, height: 40),
                                         strockColor: Color(uiColor: .iCinemaYellowColor),
                                         strockSpacing: 4, lineWidth: 1.5)
                        VStack(alignment: .leading) {
                            Text("Ahmed Yamany")
                                .foregroundColor(Color(uiColor: .iCinemaTextColor))
                                .font(Font(UIFont.callout))
                            Text("+20 1551608020")
                                .foregroundColor(.gray)
                                .font(Font(UIFont.body))
                        }
                    }
                }
                
                menuSection {
                    
                    Text("General")
                        .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                        .font(Font(UIFont.callout))
                    // Following
                    menuCell(imageSystemName: "person", text: "Following")
                    // Activity
                    menuCell(imageSystemName: "clock", text: "Activity")
                    // saved
                    menuCell(imageSystemName: "bookmark", text: "Saved")
                    // iCinema walled
                    menuCell(imageSystemName: "wallet.pass", text: "ICinema Wallet")
                    // Language
                    menuCell(imageSystemName: "globe", text: "Language")
                    // light mode
                    menuCell(imageSystemName: "sun.max", text: "Light Mode")
                }
                
                
                menuSection {
                    Text("Service")
                        .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                        .font(Font(UIFont.callout))
                    // contact us
                    menuCell(imageSystemName: "mail", text: "Contact us")
                    // about us
                    menuCell(imageSystemName: "person.3", text: "About us")
                    // Rate us
                    menuCell(imageSystemName: "star", text: "Rate us")
                    // logout
                    menuCell(imageSystemName: "iphone.and.arrow.forward", text: "Log out")
                }
                
                HStack {}
                    .listRowBackground(Color.clear)
                
            }
            .modifier(FormHiddenBackground())
            .background(Color(uiColor: .iCinemaBackgroundColor))
    }
    
    private func menuSection<Content: View>(@ViewBuilder content: @escaping () -> Content) -> some View {
        Section(content: content)
            .listRowBackground(Color(uiColor: .iCinemaSecondBackgroudColor))
            .foregroundColor(Color(uiColor: .iCinemaTextColor))
    }
    
    private func menuCell(imageSystemName: String, text: String) -> some View {
        HStack {
            Image(systemName: imageSystemName)
                .foregroundColor(Color(uiColor: .iCinemaYellowColor))
            Text(text)
                .font(Font(UIFont.body))
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}


struct FormHiddenBackground: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content.onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
//            .onDisappear {
//                UITableView.appearance().backgroundColor = .systemGroupedBackground
//            }
        }
    }
}
