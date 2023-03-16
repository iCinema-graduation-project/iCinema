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
    private let imageView: UIImageView = UIImageView(image: .welcomeImage)
    
    private let descreptionLabel: UILabel = {
        let label = UILabel()
        label.text = .welecomeDescriptionLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .iCinemaTextColor
        label.font = .callout
        return label
    }()
    
    private lazy var registerButton: ICinemaButton = ICinemaButton(title: .register, action: self.registerButtonTapped)
        
    private let guestButton: UIButton = {
        let button = UIButton()
        button.heightConstraints(.iCinemaButton.height)
        button.backgroundColor = .white
        button.layer.shadowColor = UIColor.iCinemaYellowColor.cgColor
        button.setTitleColor(.iCinemaOnlyGray, for: .normal)
        button.setTitle(.guest, for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.cornerRadius = .iCinemaButton.cornerRadius
        button.titleLabel?.font = .button
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
        imageView.sizeConstraints(width: 250, height: 250)
        imageView.centerXInSuperview()
        imageView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor)
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descreptionLabel)
        descreptionLabel.widthConstraints(.view.width)        
        descreptionLabel.centerInSuperview()
    }
    
    private func addRegisterAndGuestButtons() {
        let stackview = UIStackView(arrangedSubviews: [registerButton, guestButton])
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.distribution = .fill
        
        view.addSubview(stackview)
        stackview.centerXInSuperview()
        stackview.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: .view.padding, right: 0))
        
        guestButton.addTarget(self, action: #selector(self.guestButtonTapped(_:)), for: .touchUpInside)
        
    }
    
    // MARK: - Actions
    //
    private func registerButtonTapped() {
        self.coordinator?.push()
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
