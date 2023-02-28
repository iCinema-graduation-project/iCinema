//
//  AppTabBarView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 23/02/2023.
//

import SwiftUI
import UIKit

struct AppTabBarView: View {
    var tabs: [UIViewController]
    @State var selectedTabIndex: Int
    
    @State var xAxis: CGFloat = 0
    @Namespace var animation
    
    let currentLanguage = Locale.current.languageCode ?? "en"

    init(tabs: [UIViewController], selectedTabIndex: Int) {
        self.tabs = tabs
        self.selectedTabIndex = selectedTabIndex
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {

            TabView(selection: $selectedTabIndex) {
                ForEach(tabs, id: \.self) { viewController in
                    MakeViewControllerView(viewController: viewController)
                        .ignoresSafeArea()
                        .tag(viewController.tabBarItem.tag)
                }
            }
            
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { viewController in
                    let tag = viewController.tabBarItem.tag
                    GeometryReader { reader in
                        Button {
                            withAnimation(.spring()) {
                                selectedTabIndex = tag
                                xAxis = reader.frame(in: .global).minX + 15
                            }

                        } label: {
                            let image = (selectedTabIndex == tag ? viewController.tabBarItem.selectedImage! : viewController.tabBarItem.image!)
                            
                            Image(uiImage: image)
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25, alignment: .center)
                                .padding(selectedTabIndex == tag ? 15 : 0)
                                .foregroundColor(selectedTabIndex == tag ? Color(uiColor: .iCinemaOnlyGray) : Color(uiColor: .iCinemaTextColor))
                                .background(Color(uiColor: .iCinemaOnlyYellow).opacity(selectedTabIndex == tag ? 1 : 0 ).clipShape(Circle()))
                                .matchedGeometryEffect(id: tag, in: animation)
                                .offset(x: selectedTabIndex == tag ? ((reader.frame(in: .global).minX - reader.frame(in: .global).midX) - (currentLanguage == "ar" ?  5 : 0)) : 0 ,
                                        y: selectedTabIndex == tag ? -45 : 0)
                        }
                        .onAppear {
                            if selectedTabIndex == tag {
                                xAxis = reader.frame(in: .global).minX + 15
                            }
                        }
                    }
                    .frame(width: 25, height: 25)
                    if viewController != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical)
            .padding(.bottom, 24)
//            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .background(Color(uiColor: UIColor.gray).clipShape(CustomShape(xAxis: xAxis, curve: 30)))
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView(tabs: [], selectedTabIndex: 0)
    }
}

struct MakeViewControllerView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    let viewController: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}
