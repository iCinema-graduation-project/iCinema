//
//  WelcomeViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit



class WelcomeViewController: ICinemaViewController {
    // MARK: - Views
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
    
    private let registerButton: ICinemaButton = ICinemaButton(title: LanguageManager.register)
        
    private let guestButton: ICinemaButton = {
        let button = ICinemaButton(title: LanguageManager.guest)
        button.setTitleColor(ColorManager.iCinema, for: .normal)
        button.backgroundColor = .white
        button.layer.shadowColor = ColorManager.iCinema?.cgColor
        button.layer.shadowOpacity = 0.5
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
        
        registerButton.addTarget(self, action: #selector(self.registerButtonTapped(_:)), for: .touchUpInside)
        guestButton.addTarget(self, action: #selector(self.guestButtonTapped(_:)), for: .touchUpInside)
        
    }
    
    // MARK: = Helper methods
    //
    private func addImageView() {
        view.addSubview(imageView)
        imageView.centerXInSuperview()
        imageView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor)
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descreptionLabel)
        descreptionLabel.widthConstraints(SizeManager.textWidth)        
        descreptionLabel.centerInSuperview()
    }
    
    private func addRegisterAndGuestButtons() {
        let stackview = UIStackView(arrangedSubviews: [registerButton, guestButton])
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.distribution = .fill
        
        view.addSubview(stackview)
        stackview.centerXInSuperview()
        stackview.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0))
    }
    
    // MARK: - Actions
    //
    @objc private func registerButtonTapped(_ sender: ICinemaButton) {
        sender.addAnimate {
            self.coordinator?.push()
        }
    }
    
    @objc private func guestButtonTapped(_ sender: ICinemaButton) {
        
    }
    
}
