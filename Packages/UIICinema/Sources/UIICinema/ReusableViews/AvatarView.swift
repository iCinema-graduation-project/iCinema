//
//  AvatarView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/04/2023.
//

import UIKit
import MakeConstraints

public extension UIImage {
    @available(iOS 13, tvOS 13, *)
    static func system(_ name: String, font: UIFont) -> UIImage {
        let configuration = UIImage.SymbolConfiguration(font: font)
        return UIImage(systemName: name, withConfiguration: configuration) ?? UIImage()
    }
}

public protocol AvatarViewDelegate {
    func imageDidChanged(_ image: UIImage)
}

@available(iOS 13, *)
open class AvatarView: UIView {
    
    open var avatar = UIImageView()
    open var indicatorButton = UIButton()
    
    open var delegate: AvatarViewDelegate?
    
    let size: CGFloat
    public init(size: CGFloat, borderColor: UIColor = .label) {
        self.size = size
        super.init(frame: .zero)
        self.updatePlaceholderButton()
        self.updateIndicatorButton()
        
        avatar.makeCircleImage(withWidth: size, borderColor: borderColor)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updatePlaceholderButton() {
        addSubview(avatar)
        let padding = size / 12.5
        avatar.fillSuperviewConstraints(padding: UIEdgeInsets(top: padding,
                                                                         left: padding,
                                                                         bottom: padding,
                                                                         right: padding))
        let placeholderButtonImage = UIImage.system("person.crop.circle.fill",
                                                    font: .systemFont(ofSize: self.size,
                                                                      weight: .medium)).withTintColor(.gray)
        avatar.image = placeholderButtonImage
        avatar.tintColor = .gray
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(self.avatarImageTapped))
        avatar.addGestureRecognizer(tabGesture)
        
    }

    private func updateIndicatorButton() {
        addSubview(indicatorButton)
        let padding = size / 12.5
        indicatorButton.makeConstraints(bottomAnchor: bottomAnchor,
                                        trailingAnchor: trailingAnchor,
                                        padding: UIEdgeInsets(top: padding, left: padding,
                                                              bottom: padding, right: padding)
        )
        indicatorButton.equalSizeConstraints(30)

        let indicatorButtonImage = UIImage.system("plus.circle.fill",
                                                  font: .systemFont(ofSize: size / 3.33,
                                                                    weight: .medium))
        indicatorButton.setImage(indicatorButtonImage, for: .normal)
        indicatorButton.setImage(indicatorButtonImage, for: .selected)
        indicatorButton.addTarget(self, action: #selector(self.indicatorButtonTapped), for: .touchUpInside)
    }
    
    @objc private func avatarImageTapped() {
        
    }
    
    @objc private func indicatorButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        UIApplication.shared.keyWindow?.rootViewController?.present(imagePicker, animated: true)
        
    }
    
}

@available(iOS 13, *)
extension AvatarView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else{return}
            
        avatar.image = selectedImage
        self.delegate?.imageDidChanged(selectedImage)
        picker.dismiss(animated: true)

    }
}
