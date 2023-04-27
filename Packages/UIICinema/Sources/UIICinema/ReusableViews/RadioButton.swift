//
//  RadioButton.swift
//  iCinema
//
//  Created by Ahmed Yamany on 31/01/2023.
//

import UIKit

@available(iOS 13.0, *)
open class RadioButton: UIButton {
    open var onSelected: (_ isSelected: Bool) -> Void = {_ in}
    var selectedImage = UIImage(systemName: "checkmark.circle.fill")
    var unSelectedImage = UIImage(systemName: "circle")
        
    public init(onSelected: @escaping ((_ isSelected: Bool) -> Void) = {_ in}){
        super.init(frame: .zero)
        self.onSelected = onSelected
        setImage(unSelectedImage, for: .normal)
        setImage(selectedImage, for: .selected)
//        imageView?.tintColor = .red
        addTarget(self, action: #selector(self.radioButtonTapped(_:)), for: .touchUpInside)
    }
    
    required public init?(coder: NSCoder) {
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
