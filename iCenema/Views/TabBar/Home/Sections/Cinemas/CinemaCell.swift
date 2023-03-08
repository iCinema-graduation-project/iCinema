//
//  CinemaCell.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/03/2023.
//

import UIKit
import SwiftUI


class CinemaCell: UICollectionViewCell, IdentifiableView {
    // MARK: - Views
    //
    private let imageView = UIImageView()
    private let cinemaNameLabel = UILabel()
    private let detailsSuperView = UIView()
    private let followButton = RadioButton()
    
    // MARK: - Properties
    //
    var target: ViewController?
    var profileView: UIView?
    var profileViewAnchoredConstraints: AnchoredConstraints?
    
    
    // MARK: - intializers
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateContentView()
        self.addImageView()
        self.addDetailsSuperView()
        self.addDetailsButton()
        self.addFollowButton()
        
        imageView.image = UIImage(named: "cinema")
//        cinemaNameLabel.setTitle("Details", for: .normal)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //  MARK: - Update UI
    //
    private func updateContentView() {
        contentView.layer.cornerRadius = .viewCornerRadius
        contentView.backgroundColor = .iCinemaSecondBackgroudColor
    }
    
    // Adds an image view to the content view
    private func addImageView() {
        // Add The image View to the Content View
        contentView.addSubview(imageView)

        // Set Constraints
        imageView.centerXInSuperview()
        imageView.equalSizeConstraints(contentView.frame.width - (CGFloat.moviesPadding * 2))
        imageView.makeConstraints(topAnchor: contentView.topAnchor, padding: UIEdgeInsets(top: .moviesPadding, left: 0, bottom: 0, right: 0))
                
        // Apply Some Styling
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = .viewCornerRadius
        self.addTappGestureToImageView()
    }
    
    private func addDetailsSuperView() {
        contentView.addSubview(detailsSuperView)
        detailsSuperView.fillXSuperViewConstraints(paddingLeft: .moviesPadding, paddingRight: .moviesPadding)
        detailsSuperView.makeConstraints(topAnchor: imageView.bottomAnchor, bottomAnchor: contentView.bottomAnchor)
        detailsSuperView.clipsToBounds = true
    }
    
    // add a details button to the details super view
    private func addDetailsButton() {
        // Add the details button to the details super view
        detailsSuperView.addSubview(cinemaNameLabel)
        cinemaNameLabel.text = "Galaxy"
        cinemaNameLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        cinemaNameLabel.textColor = .iCinemaTextColor
        
        // Update The Constrints
        cinemaNameLabel.makeConstraints(leadingAnchor: detailsSuperView.leadingAnchor)
        cinemaNameLabel.centerYInSuperview()
    }
    
    private func addFollowButton() {
        followButton.setSelectedImage(.unFollow)
        followButton.setUnSelectedImage(.follow)
        detailsSuperView.addSubview(followButton)
        followButton.makeConstraints(trailingAnchor: detailsSuperView.trailingAnchor)
        followButton.centerYInSuperview()
    }
    
    
    // MARK: - Helper Methods
    //
    private func addTappGestureToImageView() {
        let tapGesure = UITapGestureRecognizer(target: self, action: #selector(self.didImageViewTapGestureTapped))
        self.imageView.addGestureRecognizer(tapGesure)
        self.imageView.isUserInteractionEnabled = true
    }
    
    
    @objc private func didImageViewTapGestureTapped(_ sender: UITapGestureRecognizer? = nil) {
        guard let target = self.target else { return }
        
        // create cinema profile view
        let cinemaProfileView = CinemaProfileView { self.dismissFullScreenAnimation() }
        guard let cinemaProfileView = UIHostingController(rootView: cinemaProfileView).view else { return }
        
        // add to target view
        target.view.addSubview(cinemaProfileView)
        self.profileView = cinemaProfileView
        
        guard let profileView = self.profileView else { return }

        // get ready to be animated
        profileView.frame = target.view.bounds
        
        UIView.animate(withDuration: 0, delay: 0) {
            profileView.makeConstraints(bottomAnchor: target.view.bottomAnchor, leadingAnchor: target.view.leadingAnchor, trailingAnchor: target.view.trailingAnchor)
            profileView.frame = .zero

        }completion: { _ in
            self.beginFullScreenAnimation()
        }

    }

    private func beginFullScreenAnimation() {
        guard let target = self.target else {return}
        
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            
            target.navigationController?.navigationBar.isHidden = true
//            iCinemaTabBar.isHidden = true
            self.profileView?.fillXSuperViewConstraints()
            self.profileViewAnchoredConstraints = self.profileView?.makeConstraints(topAnchor: target.view.topAnchor, bottomAnchor: target.view.bottomAnchor)
            
            target.view.layoutIfNeeded()
            self.profileView?.layoutIfNeeded()
        }
    }
    
    private func dismissFullScreenAnimation() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .curveLinear) {
            
            self.profileViewAnchoredConstraints?.top?.constant = 200
    
            self.target?.view.layoutIfNeeded()
            self.profileView?.layoutIfNeeded()
            self.target?.navigationController?.navigationBar.isHidden = false
//            iCinemaTabBar.isHidden = false

            
        } completion: { _ in
            self.profileView?.removeFromSuperview()
        }

    }
    

}
