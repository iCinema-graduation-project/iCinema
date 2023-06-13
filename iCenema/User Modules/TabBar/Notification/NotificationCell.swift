//
//  NotificationCell.swift
//  iCinema
//
//  Created by Ahmed Yamany on 13/06/2023.
//

import UIKit
import MakeConstraints

class NotificationCell: UICollectionViewCell, IdentifiableView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.updateUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.updateUI()
    }
    
    private func updateUI() {
        contentView.backgroundColor = .iCinemaSecondBackgroudColor
        contentView.layer.cornerRadius = CGFloat.view.cornerRadius
    }

}
