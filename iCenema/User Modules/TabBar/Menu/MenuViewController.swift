//
//  MenuViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import SwiftUI
import Combine
import MakeConstraints
import UIICinema

class MenuViewController: ICinemaViewController {
    // MARK: - Views
    lazy var menu: MenuView = MenuView(menuSections: self.menuSections)
    
    // MARK: - Properties
    //
    lazy var menuSections: [MenuSection] = [
        MenuSection(title: .menu.general, cells: [
            MenuCell(imageSystemName: "person", text: .menu.following, action: {
                self.coordinator?.push(to: FollowingViewController.self)
            }),
            
            MenuCell(imageSystemName: "clock", text: .menu.activity, action: {
                
            }),
            
            MenuCell(imageSystemName: "bookmark", text: .menu.saved, action: {
                self.coordinator?.push(to: SavedViewController.self)
            }),
            
            MenuCell(imageSystemName: "wallet.pass", text: .menu.icinemaWallet, action: {
                self.coordinator?.push(to: ICinemaWalletViewController.self)
            }),
            
            MenuCell(imageSystemName: "globe", text: .menu.language, action: {
                self.changeLangueage()
            })

        ]),
        
        MenuSection(title: .menu.service, cells: [
            MenuCell(imageSystemName: "mail", text: .menu.contactUs, action: {
                
            }),
            
            MenuCell(imageSystemName: "person.2", text: .menu.aboutUs, action: {
                
            }),
            
            MenuCell(imageSystemName: "star", text: .menu.rateUs, action: {
                self.rateUs()
            }),
            
            MenuCell(imageSystemName: "iphone.and.arrow.forward", text: .menu.logout, action: {
                self.logout()
            })
            
        ])
    ]
    
    @ObservedObject var rateViewModel = RatingViewModel()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TabBarViewModel.shared.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.layoutMenuView()
        navigationItem.addTitleView(title: .menu.menu)
    }
    
    
    // MARK: - Update UI
    //
    private func layoutMenuView() {
        let menuView = menu.hostigView()
        view.addSubview(menuView)
        
        menuView.fillXSuperViewConstraints()
        menuView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                 bottomAnchor: view.bottomAnchor)
        
    }
    
    // MARK: -  Helper
    //
    private func changeLangueage() {
        let alertView = ICinemaAlert(width: 300, height: 160)
        alertView.show {
            VStack {
                Spacer()
                Text(String.changeLanguage)
                Spacer()
                HStack {
                    Spacer()
                    CancelButtonView(title: .cancel, type: .small) {
                        alertView.hide()
                    }
                    Spacer()
                    ICinemaButtonView(title: .ok, type: .small) {
                        Task {
                            let opened = await AppSettings.shared.open()
                            print("settings opened? \(opened)")
                            alertView.hide()
                        }
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .font(Font(UIFont.body))
            .padding()
        }
    }
    
    private func rateUs() {
        let alert = ICinemaAlert(height: .screenBounds.height / 2.5)
        alert.show {
            VStack {
                RatingAndReviewView(viewModel: self.rateViewModel)
                HStack(spacing: 20.0) {
                    CancelButtonView(title: .cancel, type: .small) {
                        alert.hide()
                    }
                    
                    ICinemaButtonView(title: .send, type: .small) {
                        
                    }
                }
            }
            .padding(.bottom)
        }
    }
    private func logout() {
        let alertView = ICinemaAlert(width: 300, height: 160)
        alertView.show {
            VStack {
                Spacer()
                Text(String.menu.logoutDescription)
                Spacer()
                HStack {
                    Spacer()
                    CancelButtonView(title: .no, type: .small) {
                        alertView.hide()
                    }
                    Spacer()
                    ICinemaButtonView(title: .yes, type: .small) {
                        UserDefaults.standard.reset {
                            alertView.hide()
                                                                                    
                            UIApplication.shared.keyWindow?.windowScene?.windows.first?.rootViewController = AppCoordinator().rootViewController
                        }
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .font(Font(UIFont.body))
            .padding()
        }
    }
    
}


