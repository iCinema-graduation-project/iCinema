//
//  HeaderCollectionViewCell.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import UIKit
import Kingfisher

final class PosterCollectionViewCell: UICollectionViewCell, IdentifiableView {
    // MARK: - Views
    private let posterView: UIView =  UIView()
    private let posterImage: UIImageView = UIImageView()
    private let posterDescriptionLabel: UILabel = UILabel()
    
    private lazy var viewButton: ICinemaButton = ICinemaButton(title: .view, action: self.viewButtonTapped)
    
    
    var homeSlide: HomeSlide? = nil {
        didSet {
            guard let homeSlide = homeSlide else { return }
            posterImage.kf.setImage(with: URL(string: homeSlide.image))
        }
    }
    
    // MARK: - initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addPosterView()
        self.addViewButton()
        self.addPoterImage()
        self.addPosterDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Actions
    func viewButtonTapped(){
        
    }
    
    //  MARK: - update ui
    private func addPosterView(){
        posterView.sizeConstraints(width: .home.posters.size.width,
                                   height: .home.posters.size.height)

        posterView.backgroundColor = .iCinemaBackgroundColor
        posterView.layer.cornerRadius = .view.cornerRadius
  
        contentView.addSubview(posterView)
        posterView.addBorder(withColor: .iCinemaYellowColor)
     
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
        posterImage.heightConstraints(.home.posters.size.width)
        // FIXME: - poster image
        // will come from network
        posterImage.image = UIImage(named: "posterImage")
        posterImage.contentMode = .scaleAspectFill
    }
    private func addPosterDescriptionLabel() {
        posterView.addSubview(posterDescriptionLabel)
        posterDescriptionLabel.fillXSuperViewConstraints(paddingLeft: 2, paddingRight: 2)
        posterDescriptionLabel.makeConstraints(topAnchor: posterImage.bottomAnchor, bottomAnchor: posterView.bottomAnchor)
        
        // FIXME: -  poster description label
        // will come from network
        posterDescriptionLabel.text = "Don't miss the chance, the premiere of Avatar is in 3 days"
        posterDescriptionLabel.textColor = .iCinemaTextColor
        posterDescriptionLabel.textAlignment = .center
        posterDescriptionLabel.font = .caption1
        posterDescriptionLabel.numberOfLines = 0
        
    }
}



