//
//  HeaderCollectionViewCell.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/02/2023.
//

import UIKit
import Kingfisher
import UIICinema

final class SliderCollectionViewCell: UICollectionViewCell, IdentifiableView {
    // MARK: - Views
    private let SliderView: UIView =  UIView()
    private let SliderImage: UIImageView = UIImageView()
    private let SliderDescriptionLabel: UILabel = UILabel()
    
    private lazy var viewButton: ICinemaButton = ICinemaButton(title: .view, action: self.viewButtonTapped)
    
    var homeSlide: HomeSlide!
    var hostingViewController: ICinemaViewController!
    
    // MARK: - initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSliderView()
        self.addViewButton()
        self.addSliderImage()
        self.addSliderDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func inject(with homeSlide: HomeSlide, hostingViewController: ICinemaViewController) {
        self.homeSlide = homeSlide
        self.hostingViewController = hostingViewController
        guard let image = homeSlide.movie?.image else { return }
        SliderImage.kf.setImage(with: URL(string: image))
    }
    
    // MARK: - Actions
    private func viewButtonTapped(){
        switch self.homeSlide.type {
        case .cinema:
            guard let cinema = homeSlide.cinema else { return }
            let cinemaProfile = CinemaProfileViewController()
            cinemaProfile.inject(with: cinema.id)
            self.hostingViewController.presentViewController(cinemaProfile)
        case .movie:
            guard let movie = homeSlide.movie else { return }
            let movieProfile = MovieProfileViewController()
            movieProfile.inject(with: movie.id)
            self.hostingViewController.presentViewController(movieProfile)
        }
        
    }
    
    //  MARK: - update ui
    private func addSliderView(){
        SliderView.sizeConstraints(width: .home.Sliders.size.width,
                                   height: .home.Sliders.size.height)

        SliderView.backgroundColor = .iCinemaBackgroundColor
        SliderView.layer.cornerRadius = .view.cornerRadius
  
        contentView.addSubview(SliderView)
        SliderView.addBorder(withColor: .iCinemaYellowColor)
     
    }
    
    private func addViewButton() {
        contentView.addSubview(viewButton)
        viewButton.centerXInSuperview()
        viewButton.makeConstraints(bottomAnchor: contentView.bottomAnchor)
    }
    private func addSliderImage() {
        SliderView.addSubview(SliderImage)
        SliderImage.layer.masksToBounds = true
        SliderImage.fillXSuperViewConstraints()
        SliderImage.makeConstraints(topAnchor: SliderView.topAnchor)
        SliderImage.heightConstraints(.home.Sliders.size.width)
        // FIXME: - Slider image
        // will come from network
        SliderImage.image = UIImage(named: "SliderImage")
        SliderImage.contentMode = .scaleAspectFill
    }
    private func addSliderDescriptionLabel() {
        SliderView.addSubview(SliderDescriptionLabel)
        SliderDescriptionLabel.fillXSuperViewConstraints(paddingLeft: 2, paddingRight: 2)
        SliderDescriptionLabel.makeConstraints(topAnchor: SliderImage.bottomAnchor, bottomAnchor: SliderView.bottomAnchor)
        
        // FIXME: -  Slider description label
        // will come from network
        SliderDescriptionLabel.text = "Don't miss the chance, a new movie from Sobina cinema is in 3 days"
        SliderDescriptionLabel.textColor = .iCinemaTextColor
        SliderDescriptionLabel.textAlignment = .center
        SliderDescriptionLabel.font = .caption1
        SliderDescriptionLabel.numberOfLines = 0
        
    }
}



