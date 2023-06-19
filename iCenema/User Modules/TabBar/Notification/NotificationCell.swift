//
//  NotificationCell.swift
//  iCinema
//
//  Created by Ahmed Yamany on 13/06/2023.
//

import UIKit
import MakeConstraints

class NotificationCell: UICollectionViewCell, IdentifiableView {
    
    let imageView: UIImageView = UIImageView()
    let content: UILabel = UILabel()
    let time: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.updateUI()
    }
    
    // MARK: - Update UI
    private func updateUI() {
        contentView.backgroundColor = .iCinemaSecondBackgroudColor
        contentView.layer.cornerRadius = CGFloat.view.cornerRadius
        contentView.addSubview(imageView)
        contentView.addSubview(content)
        contentView.addSubview(time)

        updateImageView()
        updateContentLabel()
        updateTimeLabel()
    }
    private func  updateImageView() {
        imageView.image = UIImage(named: "cinema")
        imageView.fillYSuperViewConstraints(paddingTop: 8, paddingBottom: 8)
        imageView.widthConstraints(68)
        imageView.makeConstraints(leadingAnchor: contentView.leadingAnchor,
                                  padding: UIEdgeInsets(top: 8, left: 8,
                                                        bottom: 8, right: 8))
        imageView.layer.cornerRadius = CGFloat.view.cornerRadius
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.iCinemaYellowColor.cgColor
        imageView.layer.borderWidth = 1
    }
    private func updateContentLabel() {
        content.font = .body
        content.makeConstraints(topAnchor: contentView.topAnchor,
                                bottomAnchor: time.topAnchor,
                                leadingAnchor: imageView.trailingAnchor,
                                trailingAnchor: contentView.trailingAnchor,
                                
                                padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        content.text = "Your ticket is in 12 hours from now , don't forget to activate it ."
        content.numberOfLines = 0
        content.textColor = .iCinemaTextColor
    }
    
    private func updateTimeLabel() {
        time.font = .caption1
        time.textColor = .gray
        time.numberOfLines = 0
        time.makeConstraints(bottomAnchor: contentView.bottomAnchor,
                                leadingAnchor: imageView.trailingAnchor,
                                padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        time.text = "Today 10:00 PM"
    }
    

    public func update(with model: NotificationModel) {
        self.imageView.image = UIImage(named: model.image)
        self.content.text = model.title
        self.time.text = model.time
    }
    
}
