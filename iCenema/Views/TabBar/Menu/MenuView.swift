//
//  MenuView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/03/2023.
//

import SwiftUI

class MenuViewModel: ObservableObject {
    @Published var viewController: ViewController.Type? = nil
    
    public func updateViewController(viewController: ViewController.Type?) {
        self.viewController = viewController
    }
}

struct MenuView: View {
    @ObservedObject var viewModel: MenuViewModel = MenuViewModel()
    
    let menuSections: [MenuSection] = [
        MenuSection(title: "General", cells: [
            MenuCell(imageSystemName: "person", text: "Following", viewController: CinemaProfileViewController.self),
            MenuCell(imageSystemName: "clock", text: "Activity"),
            MenuCell(imageSystemName: "bookmark", text: "Saved"),
            MenuCell(imageSystemName: "wallet.pass", text: "ICinema Wallet"),
            MenuCell(imageSystemName: "globe", text: "Language"),
            MenuCell(imageSystemName: "sun.max", text: "Light Mode")
        ]),
        
        MenuSection(title: "Service", cells: [
            MenuCell(imageSystemName: "mail", text: "Contact us"),
            MenuCell(imageSystemName: "person.3", text: "About us"),
            MenuCell(imageSystemName: "star", text: "Rate us"),
            MenuCell(imageSystemName: "iphone.and.arrow.forward", text: "Log out")
        ])
    ]
    
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
           
                
                ForEach(menuSections , id: \.id) { section in
                    menuSection {
                        Text(section.title)
                            .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                            .font(Font(UIFont.callout))
                        
                        ForEach(section.cells, id: \.id) { cell in
                            Button {
                                viewModel.updateViewController(viewController: cell.viewController)
                            } label: {
                                menuCell(imageSystemName: cell.imageSystemName, text: cell.text)
                            }
                        }
                    }
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

        }
    }
}
