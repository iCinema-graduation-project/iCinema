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
        contentView.layer.cornerRadius = .view.cornerRadius
        contentView.backgroundColor = .iCinemaSecondBackgroudColor
    }
    
    // Adds an image view to the content view
    private func addImageView() {
        // Add The image View to the Content View
        contentView.addSubview(imageView)

        // Set Constraints
        imageView.centerXInSuperview()
        imageView.equalSizeConstraints(contentView.frame.width - (CGFloat.home.movies.padding * 2))
        imageView.makeConstraints(topAnchor: contentView.topAnchor, padding: UIEdgeInsets(top: .home.movies.padding, left: 0, bottom: 0, right: 0))
                
        // Apply Some Styling
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = .view.cornerRadius
        self.addTappGestureToImageView()
    }
    
    private func addDetailsSuperView() {
        contentView.addSubview(detailsSuperView)
        detailsSuperView.fillXSuperViewConstraints(paddingLeft: .home.movies.padding, paddingRight: .home.movies.padding)
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
        let cinemaProfileVC = CinemaProfileViewController()
        cinemaProfileVC.setup(cinema: nil) {
            self.target?.dismiss(completion: {
                print("good")
            })
        }
        self.target?.presentViewController(cinemaProfileVC)

    }

    

}
