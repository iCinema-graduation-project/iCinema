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
    
    @Environment(\.colorScheme) var colorScheme
    
    
    let menuSections: [MenuSection] = [
        MenuSection(title: .menu.general, cells: [
            MenuCell(imageSystemName: "person", text: .menu.following, viewController: FollowingViewController.self),
            MenuCell(imageSystemName: "clock", text: .menu.activity, viewController: FollowingViewController.self),
            MenuCell(imageSystemName: "bookmark", text: .menu.saved, viewController: FollowingViewController.self),
            MenuCell(imageSystemName: "wallet.pass", text: .menu.icinemaWallet, viewController: FollowingViewController.self),
            MenuCell(imageSystemName: "globe", text: .menu.language, viewController: FollowingViewController.self),
            MenuCell(imageSystemName: "sun.max", text: .menu.lightMode, viewController: FollowingViewController.self)
        ]),
        
        MenuSection(title: .menu.service, cells: [
            MenuCell(imageSystemName: "mail", text: .menu.contactUs, viewController: FollowingViewController.self),
            MenuCell(imageSystemName: "person.3", text: .menu.aboutUs, viewController: FollowingViewController.self),
            MenuCell(imageSystemName: "star", text: .menu.rateUs, viewController: FollowingViewController.self),
            MenuCell(imageSystemName: "iphone.and.arrow.forward", text: .menu.logout, viewController: FollowingViewController.self)
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
                            .font(Font(UIFont.title3))
                        Text("+20 1551608020")
                            .foregroundColor(.gray)
                            .font(Font(UIFont.body))
                    }
                }
                .foregroundColor(Color(uiColor: .iCinemaTextColor))
            }
            
            
            ForEach(menuSections , id: \.id) { section in
                menuSection {
                    Text(section.title)
                        .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                        .font(Font(UIFont.footnote))
                    
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
                .font(Font(UIFont.callout))
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
