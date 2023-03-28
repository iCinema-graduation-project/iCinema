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
    
    // MARK: - intializers
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateContentView()
        self.addImageView()
        self.addDetailsSuperView()
        self.addCinemaNameLabel()
        self.addFollowButton()
        
        imageView.image = UIImage(named: "cinema")
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
        imageView.equalSizeConstraints(contentView.frame.width - (CGFloat.cell.padding.left * 2))
        imageView.makeConstraints(topAnchor: contentView.topAnchor, padding: UIEdgeInsets(top: .cell.padding.top, left: 0, bottom: 0, right: 0))
    
        // Apply Some Styling
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = .view.cornerRadius
        
    }
    
    private func addDetailsSuperView() {
        contentView.addSubview(detailsSuperView)
        detailsSuperView.fillXSuperViewConstraints(paddingLeft: .cell.padding.left, paddingRight: .cell.padding.right)
        detailsSuperView.makeConstraints(topAnchor: imageView.bottomAnchor, bottomAnchor: contentView.bottomAnchor)
        detailsSuperView.clipsToBounds = true
    }
    
    // add a details button to the details super view
    private func addCinemaNameLabel() {
        // Add the details button to the details super view
        detailsSuperView.addSubview(cinemaNameLabel)
        cinemaNameLabel.text = "Galaxy"
        cinemaNameLabel.font = .callout
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
    

}
