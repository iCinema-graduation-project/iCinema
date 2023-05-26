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
        self.navigationController?.pushViewController(EditUserProfileViewController(), animated: true)
    }
    
    
    @objc private func startQRCodeScanning() {
        let vc = QRCodeViewController()

        self.present(vc, animated: true)
    }
    
  
    
}

