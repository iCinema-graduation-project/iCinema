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
    @ObservedObject var tabBarViewModel: TabBarViewModel
    
    init(tabs: [UIViewController], tabBarViewModel: TabBarViewModel) {
        self.tabs = tabs
        self.tabBarViewModel = tabBarViewModel
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            // TabBar View Controllers
            TabView(selection: $tabBarViewModel.selectedTabIndex) {
                ForEach(tabs, id: \.self) { viewController in
                    MakeViewControllerView(viewController: viewController)
                        .ignoresSafeArea()
                        .tag(viewController.tabBarItem.tag)
                }
            }
            
            // TabBar View
            if !tabBarViewModel.isHidden {
                
                TabBarView(tabs: tabs)
                    .environmentObject(tabBarViewModel)
                
            }
        
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct TabBarView: View {
    
    var tabs: [UIViewController]
    @EnvironmentObject var viewModel: TabBarViewModel
    
    @Namespace var animation
    let currentLanguage = Locale.current.languageCode ?? "en"
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs, id: \.self) { viewController in
                let tag = viewController.tabBarItem.tag
                GeometryReader { reader in

                    Button {
                        withAnimation(.spring()) {
                            viewModel.selectedTabIndex = tag
                        }
                        
                    } label: {
                        
                        let image = (viewModel.selectedTabIndex == tag ? viewController.tabBarItem.selectedImage! : viewController.tabBarItem.image!)

                        Image(uiImage: image)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25, alignment: .center)
                            .padding(viewModel.selectedTabIndex == tag ? 15 : 0)
                            .foregroundColor(viewModel.selectedTabIndex == tag ? Color(uiColor: .iCinemaOnlyGray) : Color(uiColor: .iCinemaTextColor))
                            .background(Color(uiColor: .iCinemaOnlyYellow).opacity(viewModel.selectedTabIndex == tag ? 1 : 0 ).clipShape(Circle()))
                            .matchedGeometryEffect(id: tag, in: animation)
                            .offset(x: imageOffsetX(tag, reader), y: viewModel.selectedTabIndex == tag ? -45 : 0)
                        
                    }
                    .onAppear {
                        
                        viewModel.readers.append(reader)

                        if viewModel.selectedTabIndex == tag {
                            viewModel.xAxis = reader.frame(in: .global).minX + 15
                        }
                    }
                    
                }
                .frame(width: 25, height:25)
                if viewController != tabs.last {
                    Spacer(minLength: 0)
                }
            }
        }
        .padding(.horizontal, 40)
        .padding(.vertical)
//        .padding(.bottom, 12)
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        .background(Color(uiColor: UIColor.iCinemaSecondBackgroudColor)
        .clipShape(TabBarCurveShape(xAxis: viewModel.xAxis, curve: 30)))

    }
    
    private func imageOffsetX(_ tag:Int, _ reader: GeometryProxy) -> CGFloat {
        viewModel.selectedTabIndex == tag ? ((reader.frame(in: .global).minX - reader.frame(in: .global).midX) - (currentLanguage == "ar" ?  5 : 0)) : 0
    }
    
}


struct AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView(tabs: [], tabBarViewModel: TabBarViewModel())
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
