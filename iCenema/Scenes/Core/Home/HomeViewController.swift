//
//  HomeViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit

class HomeViewController: ICinemaViewController {
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.addTitleView(title: "ICinema")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .magnifyingglass, style: .plain, target: self, action: nil)
        self.addUserProfileImageToLeftBarButtonItem()
    }
    
    
    // MARK: - Update UI
    private func addUserProfileImageToLeftBarButtonItem(){
        let imageView = UIImageView(image: .profile).makeCircleImage(withWidth: 28)
        imageView.layer.borderColor = UIColor.iCinemaYellowColor.cgColor
        imageView.layer.borderWidth = 1.5
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageView)
        
    }
    
}
