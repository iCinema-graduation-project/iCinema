//
//  BookingSuccessViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 15/04/2023.
//

import UIKit
import SwiftUI
import ViewAnimator
import SPConfetti
import MakeConstraints

final class BookingSuccessViewController: ICinemaViewController {
    // MARK: - Views
    let imageView: UIImageView = UIImageView(image: UIImage(named: "tikets.done"))
    
    private let descreptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Your tickets had been successfully booked , you can get it anytime from Booking ."
        return label
    }()
    
    private lazy var viewBookingButton: ICinemaButton = ICinemaButton(title: "View Booking", action: self.viewBookingButtonTapped)
        
    private lazy var homeButton = CancelButton(title: "Home", action: self.homeButtonTapped)

    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
         
        addImageView()
        addDescriptionLabel()
        addRegisterAndGuestButtons()
        
        SPConfetti.startAnimating(.centerWidthToDown, particles: [ .star, .heart], duration: 3)

    }
    
    private func addImageView() {
        view.addSubview(imageView)
        imageView.fillXSuperViewConstraints(paddingLeft: .view.padding.left,
                                            paddingRight: .view.padding.right)

        imageView.centerInSuperview()
        imageView.heightConstraints(300)
        
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        imageView.animate(animations: [zoomAnimation])
        
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descreptionLabel)
        descreptionLabel.makeDescreptionLabel()
        descreptionLabel.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor,
                                  padding: CGFloat.view.padding)

    }
    
    private func addRegisterAndGuestButtons() {
        let stackview = UIStackView(arrangedSubviews: [viewBookingButton, homeButton])
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.distribution = .fill
        
        view.addSubview(stackview)
        stackview.centerXInSuperview()
        stackview.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                  padding: UIEdgeInsets(top: 0, left: 0, bottom: .view.padding.bottom, right: 0))
        
    }
    
    // MARK: - Actions
    //
    private func viewBookingButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            TabBarViewModel.shared.selectedTabIndex = 3
        })
    }
    
    private func homeButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}


struct BookingSuccessView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: BookingSuccessViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct BookingSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        BookingSuccessView()
            .ignoresSafeArea()
    }
}
