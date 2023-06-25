//
//  HomeViewController.swift
//  ICinemaForCinemas
//
//  Created by Ahmed Yamany on 24/05/2023.
//

import UIKit
import QRScanner
import AVFoundation
import MakeConstraints
import Coordinator
import SwiftUI

final class CinemaHomeViewController: ICinemaViewController {

    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TabBarViewModel.shared.show()
    }
    
    // MARK: - Update UI
    private func updateUI(){
        navigationItem.addTitleView(title: "ICinema")
        self.addScanQRButton()
        self.addUserProfileImageToLeftBarButtonItem()
    }
    private func addScanQRButton(){
        let image = UIImage.cinemaUser.scanQR
            .withTintColor(.iCinemaYellowColor, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.equalSizeConstraints(30)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: imageView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.startQRCodeScanning))
        imageView.addGestureRecognizer(gesture)
    }
    private func addUserProfileImageToLeftBarButtonItem(){
        let imageView = UIImageView()
            .makeCircleImage(withWidth: .profile.imageSize.width, borderColor: .iCinemaYellowColor)
            
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.userProfileTapped))
        imageView.addGestureRecognizer(gesture)
    }

    
    // MARK: - Actions
    //
    @objc private func userProfileTapped() {
        let alertView = ICinemaAlert(width: 328, height: 464, useBackground: false)
        alertView.show {
            VStack(spacing: 0.0) {
//                TicketTopView(ticket: Ticket(image: "thor-top"))
//                Spacer(minLength: 0)
//                TicketBottomView()
            }
            .frame(height: 460)
            .font(Font(UIFont.callout))
            .glow(color: Color(uiColor: .iCinemaYellowColor), radius: 1)
        }

    }
    @objc private func startQRCodeScanning() {
        let vc = QRCodeViewController()
        self.present(vc, animated: true)
    }
    
}

