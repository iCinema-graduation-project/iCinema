//
//  WelcomeViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit
import SwiftUI


class WelcomeViewController: ICinemaViewController {
    // MARK: - Views
    //
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: ImageManager.welcomeImage)
        imageView.sizeConstraints(width: 250, height: 250)
        return imageView
    }()
    
    private let descreptionLabel: UILabel = {
        let label = UILabel()
        label.text = LanguageManager.welecomeDescriptionLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = ColorManager.textColor
        return label
    }()
    
    private let registerButton: ICinemaButton = ICinemaButton(title: LanguageManager.register)
        
    private let guestButton: ICinemaButton = {
        let button = ICinemaButton(title: LanguageManager.guest)
        button.backgroundColor = .white
        button.layer.shadowColor = ColorManager.iCinemaYellow.cgColor
        button.setTitleColor(ColorManager.iCinemaGray, for: .normal)
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
    }
    
    // MARK: - Helper methods
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
        
        registerButton.addTarget(self, action: #selector(self.registerButtonTapped(_:)), for: .touchUpInside)
        guestButton.addTarget(self, action: #selector(self.guestButtonTapped(_:)), for: .touchUpInside)
        
    }
    
    // MARK: - Actions
    //
    @objc private func registerButtonTapped(_ sender: ICinemaButton) {
        sender.addAnimate {
            self.coordinator?.push()
        }
    }
    
    @objc private func guestButtonTapped(_ sender: ICinemaButton) {
        sender.addAnimate()
    }
    
}

struct WelcomeView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return WelcomeViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .ignoresSafeArea()
    }
}
