//
//  MenuView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/03/2023.
//

import SwiftUI

struct MenuView: View {
    let menuSections: [MenuSection]
    
    @State private var profileFeatcher = ProfileFetcher()
    
    @State private var image: String = ""
    @State private var name: String = ""
    @State private var phone: String = ""
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        
        ICinemaView {
            List {
                menuSection {
                    HStack(spacing: 15.0) {
                        
                        ICinemaAsyncImage(url: URL(string: image)) { image in
                            image
                                .resizable()
                                .frame(width: 40, height: 40)

                        }
                        .makeCircled(size: CGSize(width: 40, height: 40),
                                     strockColor: Color(uiColor: .iCinemaYellowColor),
                                     strockSpacing: 4, lineWidth: 1.5)
                    
                        
                        VStack(alignment: .leading) {
                            Text(name.capitalized)
                                .font(Font(UIFont.title3))
                            
                            Text(phone)
                                .foregroundColor(.gray)
                                .font(Font(UIFont.body))
                        }
                    }
                    .foregroundColor(Color(uiColor: .iCinemaTextColor))
                }
                .onAppear {
                    profileFeatcher.request { response in
                        guard let value = response.value else { return }
                        self.image = value.user.image ?? ""
                        self.name = value.user.name ?? ""
                        self.phone = value.user.phone
                    }
                }
                
                ForEach(menuSections , id: \.id) { section in
                    menuSection {
                        Text(section.title)
                            .foregroundColor(Color(uiColor: .iCinemaYellowColor))
                            .font(Font(UIFont.footnote))
                        
                        ForEach(section.cells, id: \.id) { cell in
                            menuCell(imageSystemName: cell.imageSystemName, text: cell.text)
                                .onTapGesture {
                                    cell.action()
                                }
                        }
                    }
                }
                
                HStack {}
                    .frame(height: 50)
                    .listRowBackground(Color.clear)
            }
            .modifier(FormHiddenBackground())
            .background(Color(uiColor: .iCinemaBackgroundColor))
        }
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
            Spacer()
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(menuSections: [])
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
