//
//  HeaderCollectionViewCell.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import UIKit

final class PosterCollectionViewCell: UICollectionViewCell {
    // MARK: - Views
    private let posterView: UIView =  UIView()
    private let viewButton: ICinemaButton = ICinemaButton(title: "View")
    private let posterImage: UIImageView = UIImageView()
    private let posterDescriptionLabel: UILabel = UILabel()
    
    // MARK: - initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addPosterView()
        self.addViewButton()
        self.addPoterImage()
        self.addPosterDescriptionLabel()
        
        viewButton.addTarget(self, action: #selector(self.viewButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Actions
    @objc func viewButtonTapped(_ sender: ICinemaButton){
        sender.addAnimate {
            print("tapped")
        }
    }
    
    //  MARK: - update ui
    private func addPosterView(){
        contentView.addSubview(posterView)
        /// update poster view's constraints
        posterView.sizeConstraints(width: .homePoseterWidth, height: .homePosterHeight)
        posterView.centerXInSuperview()
        posterView.makeConstraints(topAnchor: contentView.topAnchor)
        
        /// update poster view's UI
        posterView.layer.masksToBounds = true
        posterView.backgroundColor = .clear
        posterView.layer.cornerRadius = .viewCornerRadius
        posterView.layer.borderColor = UIColor.iCinemaYellowColor.cgColor
        posterView.layer.borderWidth = 1
    }
    
    private func addViewButton() {
        contentView.addSubview(viewButton)
        viewButton.centerXInSuperview()
        viewButton.makeConstraints(bottomAnchor: contentView.bottomAnchor)
    }
    
    private func addPoterImage() {
        posterView.addSubview(posterImage)
        posterImage.layer.masksToBounds = true
        posterImage.fillXSuperViewConstraints()
        posterImage.makeConstraints(topAnchor: posterView.topAnchor)
        posterImage.heightConstraints(.homePoseterWidth)
        posterImage.image = UIImage(named: "posterImage")
        posterImage.contentMode = .scaleAspectFill
    }
    
    private func addPosterDescriptionLabel() {
        posterView.addSubview(posterDescriptionLabel)
        posterDescriptionLabel.fillXSuperViewConstraints()
        posterDescriptionLabel.makeConstraints(topAnchor: posterImage.bottomAnchor, bottomAnchor: posterView.bottomAnchor)
        
        
        posterDescriptionLabel.text = "Don't miss the chance, the premiere of Avatar is in 3 days"
        posterDescriptionLabel.textColor = .iCinemaTextColor
        posterDescriptionLabel.textAlignment = .center
        posterDescriptionLabel.font = .systemFont(ofSize: 12)
        posterDescriptionLabel.numberOfLines = 0
    }
    
    
}

// MARK: - IdentifiableView
extension PosterCollectionViewCell: IdentifiableView { }
