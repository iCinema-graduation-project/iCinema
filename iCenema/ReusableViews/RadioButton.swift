//
//  RadioButton.swift
//  iCinema
//
//  Created by Ahmed Yamany on 31/01/2023.
//

import UIKit

class RadioButton: UIButton {
    var onSelected: (_ isSelected: Bool) -> Void = {_ in}
    var selectedImage = UIImage(systemName: "checkmark.circle.fill")
    var unSelectedImage = UIImage(systemName: "circle")
    
    override var tintColor: UIColor! {
        didSet {
            setTitleColor(tintColor, for: .normal)
        }
    }
    
    init(onSelected: @escaping ((_ isSelected: Bool) -> Void) = {_ in}){
        super.init(frame: .zero)
        self.onSelected = onSelected
        setImage(unSelectedImage, for: .normal)
        setImage(selectedImage, for: .selected)
        imageView?.tintColor = .iCinemaYellowColor
        addTarget(self, action: #selector(self.radioButtonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func radioButtonTapped(_ sender: RadioButton) {
        isSelected.toggle()
        onSelected(isSelected)
    }
    
    public func setSelectedImage(_ image: UIImage?) {
        setImage(image, for: .selected)
    }
    
    public func setUnSelectedImage( _ image: UIImage?) {
        setImage(image, for: .normal)
    }
    
}
