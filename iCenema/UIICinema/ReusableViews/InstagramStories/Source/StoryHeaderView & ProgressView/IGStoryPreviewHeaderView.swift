//
//  IGStoryPreviewHeaderView.swift
//  InstagramStories
//
//  Created by Boominadha Prakash on 06/09/17.
//  Copyright © 2017 DrawRect. All rights reserved.
//

import UIKit

protocol StoryPreviewHeaderProtocol: AnyObject {
    func didTapCloseButton()
}

fileprivate let maxSnaps = 30

//Identifiers
public let progressIndicatorViewTag = 88
public let progressViewTag = 99

final class IGStoryPreviewHeaderView: UIView {
    
    // MARK: - Views
    fileprivate var progressView: UIView?
    
    internal let snaperImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.iCinemaYellowColor.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let detailView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let snaperNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    internal let lastUpdatedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        // FIXME: image
        button.setImage(UIImage(systemName: "x.circle"), for: .normal)
        button.addTarget(self, action: #selector(didTapClose(_:)), for: .touchUpInside)
        return button
    }()
     
    public var getProgressView: UIView {
        if let progressView = self.progressView {
            return progressView
        }
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        self.progressView = v
        self.addSubview(self.getProgressView)
        return v
    }
    
    internal let followButton: UIButton = {
        let button = UIButton()
        
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.backgroundColor = .clear
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.iCinemaYellowColor, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 8, weight: .semibold)
        button.layer.borderColor = UIColor.iCinemaYellowColor.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    
    // MARK: - Properties
    public weak var delegate: StoryPreviewHeaderProtocol?
    fileprivate var snapsPerStory: Int = 0
    public var story:IGStory? {
        didSet {
            snapsPerStory = (story?.snapsCount)! < maxSnaps ? (story?.snapsCount)! : maxSnaps
            if let picture = story?.user.picture {
                snaperImageView.setImage(url: picture)
            }
        }
    }
    
    //MARK: - Overriden functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        backgroundColor = .clear
        applyShadowOffset()
        installLayoutConstraints()
        addFollowButton()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Update UI
    private func addFollowButton() {
        addSubview(followButton)
        followButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followButton.igLeftAnchor.constraint(equalTo: lastUpdatedLabel.igRightAnchor, constant: 20),
            followButton.igCenterYAnchor.constraint(equalTo: igCenterYAnchor)
        ])
    }
    
    private func installLayoutConstraints(){
        //Setting constraints for progressView
        self.addProgressView()
        //Setting constraints for snapperImageView
        self.addSnapperView()
        //Setting constraints for detailView
        self.addDetailView()
        //Setting constraints for closeButton
//        self.addCloseButton()
    }
    
    private func addProgressView() {
        addSubview(getProgressView)
        let pv = getProgressView
        NSLayoutConstraint.activate([
            pv.igLeftAnchor.constraint(equalTo: self.igLeftAnchor),
            pv.igTopAnchor.constraint(equalTo: self.igTopAnchor, constant: 8),
            self.igRightAnchor.constraint(equalTo: pv.igRightAnchor),
            pv.heightAnchor.constraint(equalToConstant: 10)
            ])
    }
    
    private func addSnapperView() {
        addSubview(snaperImageView)
        NSLayoutConstraint.activate([
            snaperImageView.widthAnchor.constraint(equalToConstant: 40),
            snaperImageView.heightAnchor.constraint(equalToConstant: 40),
            snaperImageView.igLeftAnchor.constraint(equalTo: self.igLeftAnchor, constant: 10),
            snaperImageView.igCenterYAnchor.constraint(equalTo: self.igCenterYAnchor),
            ])
        layoutIfNeeded() //To make snaperImageView round. Adding this to somewhere else will create constraint warnings.
    }
    
    private func addDetailView() {
        addSubview(detailView)
        detailView.addSubview(snaperNameLabel)
        detailView.addSubview(lastUpdatedLabel)
        
        NSLayoutConstraint.activate([
            detailView.igLeftAnchor.constraint(equalTo: snaperImageView.igRightAnchor, constant: 10),
//            detailView.igCenterYAnchor.constraint(equalTo: snaperImageView.igCenterYAnchor),
            detailView.igTopAnchor.constraint(equalTo: snaperImageView.igTopAnchor),
            detailView.heightAnchor.constraint(equalToConstant: 40),
            ])
        
        //Setting constraints for snapperNameLabel
        NSLayoutConstraint.activate([
            snaperNameLabel.igLeftAnchor.constraint(equalTo: detailView.igLeftAnchor),
            snaperNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 70),
            snaperNameLabel.igTopAnchor.constraint(equalTo: detailView.igTopAnchor)
            ])
        //Setting constraints for lastUpdatedLabel
        NSLayoutConstraint.activate([
            lastUpdatedLabel.igTopAnchor.constraint(equalTo: snaperNameLabel.igBottomAnchor),
            lastUpdatedLabel.igLeftAnchor.constraint(equalTo: detailView.igLeftAnchor),
            ])

    }
    
    private func addCloseButton() {
        NSLayoutConstraint.activate([
            closeButton.igLeftAnchor.constraint(equalTo: detailView.igRightAnchor, constant: 10),
            closeButton.igCenterYAnchor.constraint(equalTo: self.igCenterYAnchor),
            closeButton.igRightAnchor.constraint(equalTo: self.igRightAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 60),
            closeButton.heightAnchor.constraint(equalToConstant: 80)
            ])
    }
    private func applyShadowOffset() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
    }
    private func applyProperties<T: UIView>(_ view: T, with tag: Int? = nil, alpha: CGFloat = 1.0) -> T {
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.iCinemaYellowColor.withAlphaComponent(alpha)
        if let tagValue = tag {
            view.tag = tagValue
        }
        return view
    }
    
    //MARK: - Selectors
    @objc func didTapClose(_ sender: UIButton) {
        delegate?.didTapCloseButton()
    }
    
    //MARK: - Public functions
    public func clearTheProgressorSubviews() {
        getProgressView.subviews.forEach { v in
            v.subviews.forEach{v in (v as! IGSnapProgressView).stop()}
            v.removeFromSuperview()
        }
    }
    public func clearAllProgressors() {
        clearTheProgressorSubviews()
        getProgressView.removeFromSuperview()
        self.progressView = nil
    }
    public func clearSnapProgressor(at index:Int) {
        getProgressView.subviews[index].removeFromSuperview()
    }
    public func createSnapProgressors(){
        print("Progressor count: \(getProgressView.subviews.count)")
        let padding: CGFloat = 8 //GUI-Padding
        let height: CGFloat = 3
        var pvIndicatorArray: [IGSnapProgressIndicatorView] = []
        var pvArray: [IGSnapProgressView] = []
        
        // Adding all ProgressView Indicator and ProgressView to seperate arrays
        for i in 0..<snapsPerStory{
            let pvIndicator = IGSnapProgressIndicatorView()
            pvIndicator.translatesAutoresizingMaskIntoConstraints = false
            getProgressView.addSubview(applyProperties(pvIndicator, with: i+progressIndicatorViewTag, alpha:0.2))
            pvIndicatorArray.append(pvIndicator)
            
            let pv = IGSnapProgressView()
            pv.translatesAutoresizingMaskIntoConstraints = false
            pvIndicator.addSubview(applyProperties(pv))
            pvArray.append(pv)
        }
        // Setting Constraints for all progressView indicators
        for index in 0..<pvIndicatorArray.count {
            let pvIndicator = pvIndicatorArray[index]
            if index == 0 {
                pvIndicator.leftConstraiant = pvIndicator.igLeftAnchor.constraint(equalTo: self.getProgressView.igLeftAnchor, constant: padding)
                NSLayoutConstraint.activate([
                    pvIndicator.leftConstraiant!,
                    pvIndicator.igCenterYAnchor.constraint(equalTo: self.getProgressView.igCenterYAnchor),
                    pvIndicator.heightAnchor.constraint(equalToConstant: height)
                    ])
                if pvIndicatorArray.count == 1 {
                    pvIndicator.rightConstraiant = self.getProgressView.igRightAnchor.constraint(equalTo: pvIndicator.igRightAnchor, constant: padding)
                    pvIndicator.rightConstraiant!.isActive = true
                }
            }else {
                let prePVIndicator = pvIndicatorArray[index-1]
                pvIndicator.widthConstraint = pvIndicator.widthAnchor.constraint(equalTo: prePVIndicator.widthAnchor, multiplier: 1.0)
                pvIndicator.leftConstraiant = pvIndicator.igLeftAnchor.constraint(equalTo: prePVIndicator.igRightAnchor, constant: padding)
                NSLayoutConstraint.activate([
                    pvIndicator.leftConstraiant!,
                    pvIndicator.igCenterYAnchor.constraint(equalTo: prePVIndicator.igCenterYAnchor),
                    pvIndicator.heightAnchor.constraint(equalToConstant: height),
                    pvIndicator.widthConstraint!
                    ])
                if index == pvIndicatorArray.count-1 {
                    pvIndicator.rightConstraiant = self.igRightAnchor.constraint(equalTo: pvIndicator.igRightAnchor, constant: padding)
                    pvIndicator.rightConstraiant!.isActive = true
                }
            }
        }
        // Setting Constraints for all progressViews
        for index in 0..<pvArray.count {
            let pv = pvArray[index]
            let pvIndicator = pvIndicatorArray[index]
            pv.widthConstraint = pv.widthAnchor.constraint(equalToConstant: 0)
            NSLayoutConstraint.activate([
                pv.igLeftAnchor.constraint(equalTo: pvIndicator.igLeftAnchor),
                pv.heightAnchor.constraint(equalTo: pvIndicator.heightAnchor),
                pv.igTopAnchor.constraint(equalTo: pvIndicator.igTopAnchor),
                pv.widthConstraint!
                ])
        }
        snaperNameLabel.text = story?.user.name
    }
}
