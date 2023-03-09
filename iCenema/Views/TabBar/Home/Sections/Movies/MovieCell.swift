//
//  MovieCell.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import UIKit

class MovieCell: UICollectionViewCell, IdentifiableView {
    // MARK: - Views
    //
    private let imageView = UIImageView()
    private let imageSuperView = UIView()
    private let detailsButton = UIButton()
    private let detailsSuperView = UIView()
    private let bookMarkButton = RadioButton()
    
    // MARK: - initialization
    //
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateContentView()
        self.addImageView()
        self.addDetailsSuperView()
        self.addDetailsButton()
        self.addBookMarkButton()
        
        // update on network request
        imageView.image = UIImage(named: "poserImage2")
        detailsButton.setTitle("Details", for: .normal)
        detailsButton.addTarget(self, action: #selector(self.detailsButtonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Actions
    @objc func detailsButtonTapped(_ sender: UIButton) {
        print("tapped")
    }
    
    
    //  MARK: - Update UI
    //
    private func updateContentView() {
        contentView.layer.cornerRadius = .view.cornerRadius
        contentView.backgroundColor = .iCinemaSecondBackgroudColor
    }
    
    // Adds an image view to the content view
    private func addImageView() {
        // Add The image Super View to the Content View
        contentView.addSubview(imageSuperView)

        // Set Constraints For The New View
        imageSuperView.fillXSuperViewConstraints(paddingLeft: .home.movies.padding, paddingRight: .home.movies.padding)
        imageSuperView.makeConstraints(topAnchor: contentView.topAnchor, padding: UIEdgeInsets(top: .home.movies.padding, left: 0, bottom: 0, right: 0))
        imageSuperView.heightConstraints(contentView.frame.height / 1.24)
        
        // Apply Some Styling To The New View
        imageSuperView.layer.masksToBounds = true
        imageSuperView.layer.cornerRadius = .view.cornerRadius
        imageSuperView.backgroundColor = .iCinemaYellowColor
        
        // Add imageView To its Super View
        imageSuperView.addSubview(imageView)
        imageView.fillSuperviewConstraints(padding: UIEdgeInsets(top: 0.2, left: 0.2, bottom: 1.6, right: 0.2))
        imageView.layer.cornerRadius = .view.cornerRadius
        imageView.layer.masksToBounds = true
        
    }

    private func addDetailsSuperView() {
        contentView.addSubview(detailsSuperView)
        detailsSuperView.fillXSuperViewConstraints(paddingLeft: .home.movies.padding, paddingRight: .home.movies.padding)
        detailsSuperView.makeConstraints(topAnchor: imageSuperView.bottomAnchor, bottomAnchor: contentView.bottomAnchor)
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
    
    private func addBookMarkButton() {
        bookMarkButton.setSelectedImage(.bookmarkFill)
        bookMarkButton.setUnSelectedImage(.bookmark)
        
        detailsSuperView.addSubview(bookMarkButton)
        bookMarkButton.makeConstraints(trailingAnchor: detailsSuperView.trailingAnchor)
        bookMarkButton.centerYInSuperview()
    }
    
    
    
}
