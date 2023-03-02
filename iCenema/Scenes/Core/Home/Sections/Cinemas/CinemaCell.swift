//
//  CinemaCell.swift
//  iCinema
//
//  Created by Ahmed Yamany on 01/03/2023.
//

import UIKit

class CinemaCell: UICollectionViewCell, IdentifiableView {
    // MARK: - Views
    //
    private let imageView = UIImageView()
    private let detailsButton = UIButton()
    private let detailsSuperView = UIView()
    private let followButton = RadioButton()
    
    // MARK: - initialization
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateContentView()
        self.addImageView()
        self.addDetailsSuperView()
        self.addDetailsButton()
        self.addFollowButton()
        
        imageView.image = UIImage(named: "cinema")
        detailsButton.setTitle("Details", for: .normal)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Actions
    
    
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
        detailsSuperView.addSubview(detailsButton)
        
        // Configure the button
        let configuration = UIButton.Configuration.plain()
        detailsButton.configuration = configuration
        // Update the Button's font
        detailsButton.configuration?.titleTextAttributesTransformer  =
        UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .subheadline)
            return outgoing
        }
        detailsButton.tintColor = .iCinemaTextColor
        
        // Update The Button's Constrints
        detailsButton.makeConstraints(leadingAnchor: detailsSuperView.leadingAnchor)
        detailsButton.centerYInSuperview()
    }
    
    private func addFollowButton() {
        followButton.setSelectedImage(.unFollow)
        followButton.setUnSelectedImage(.follow)
        detailsSuperView.addSubview(followButton)
        followButton.makeConstraints(trailingAnchor: detailsSuperView.trailingAnchor)
        followButton.centerYInSuperview()
        
//        let configuration = UIButton.Configuration.plain()
//        detailsButton.configuration = configuration
//        detailsButton.configuration?.buttonSize = .large
        
        
    }


}
