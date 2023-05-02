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
    
    
    var homeSlide: HomeSlide? = nil {
        didSet {
            guard let homeSlide = homeSlide else { return }
            SliderImage.kf.setImage(with: URL(string: homeSlide.image))
        }
    }
    
    // MARK: - initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSliderView()
        self.addViewButton()
        self.addPoterImage()
        self.addSliderDescriptionLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Actions
    func viewButtonTapped(){
        
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
    private func addPoterImage() {
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
        SliderDescriptionLabel.text = "Don't miss the chance, the premiere of Avatar is in 3 days"
        SliderDescriptionLabel.textColor = .iCinemaTextColor
        SliderDescriptionLabel.textAlignment = .center
        SliderDescriptionLabel.font = .caption1
        SliderDescriptionLabel.numberOfLines = 0
        
    }
}



