//
//  WelcomeViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit

class WelcomeViewController: ViewController {
    // MARK: - Properties
    //
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: ImageManager.welcomeImage)
        imageView.sizeConstraints(width: 250, height: 180)
        return imageView
    }()
    
    private let descreptionLabel: UILabel = {
        let label = UILabel()
        label.text = LanguageManager.welecomeDescriptionLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private let registerButton: iCinemaButton = {
        let button = iCinemaButton()
        button.setTitle(LanguageManager.register, for: .normal)
        return button
    }()
    
    private let guestButton: iCinemaButton = {
        let button = iCinemaButton()
        button.setTitle(LanguageManager.guest, for: .normal)
        button.setTitleColor(ColorManager.iCinemaReverce, for: .normal)
        button.backgroundColor = .white
        button.layer.shadowColor = ColorManager.iCinemaReverce?.cgColor
        button.layer.shadowOpacity = 2
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        return button
    }()
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        addImageView()
        addDescriptionLabel()
        addRegisterAndGuestButtons()
    }
    
    // MARK: = Helper methods
    //
    private func addImageView() {
        view.addSubview(imageView)
        imageView.centerXInSuperview()
        imageView.makeConstraints(topAnchor: view.topAnchor, padding: UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0))
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descreptionLabel)
        descreptionLabel.widthConstraints(326)
        descreptionLabel.centerInSuperview()
    }
    
    private func addRegisterAndGuestButtons() {
        let stackview = UIStackView(arrangedSubviews: [registerButton, guestButton])
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.distribution = .fill
        
        view.addSubview(stackview)
        stackview.centerXInSuperview()
        stackview.makeConstraints(bottomAnchor: view.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0))
    }
    
}
