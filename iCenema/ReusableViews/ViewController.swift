//
//  ViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 09/03/2023.
//

import UIKit


class ViewController: UIViewController{
    // used to store properities when presenting view controller
    private weak var presentedView:  UIView?
    public var presentedViewAnchoredConstraints: AnchoredConstraints?
    
    // the coordinator is responsible for managing navigation between view controllers.
    var coordinator: Coordinator?
    var coordinatorType: CoordinatorType = .navigation
    
    // used to notify the coordinator when the view controller is popped from the navigation stack.
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            self.coordinator?.pop()
        }
    }
    
    // This Method presents the given view controller on top of the current view controller.
    @objc public func presentViewController(_ viewControllerToPresent: UIViewController, completion: @escaping () -> Void = {} ){
        // Set the presentedView property to the view of the view controller being presented.
        self.presentedView = viewControllerToPresent.view
        
        // Add the presentedView to the current view controller's view hierarchy
        guard let presentedView = self.presentedView else { return }
        self.view.addSubview(presentedView)
        presentedView.frame = self.view.bounds

        // Animate the presentation of the presentedView.
        UIView.animate(withDuration: 0, delay: 0) {
            presentedView.makeConstraints(
                                        bottomAnchor: self.view.bottomAnchor,
                                        leadingAnchor: self.view.leadingAnchor,
                                        trailingAnchor: self.view.trailingAnchor)

            presentedView.frame = .zero
        }completion: { _ in
            self.beginFullScreenAnimation(completion: completion)
        }
        
    }
    
    private func beginFullScreenAnimation(completion: @escaping () -> Void) {
        guard let presentedView = self.presentedView else { return }

        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseOut) {
            
            self.navigationController?.navigationBar.isHidden = true
            presentedView.fillXSuperViewConstraints()
            self.presentedViewAnchoredConstraints = presentedView.makeConstraints(topAnchor: self.view.topAnchor, bottomAnchor: self.view.bottomAnchor)
            
            self.view.layoutIfNeeded()
            presentedView.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
    
    @objc public func dismiss(completion: @escaping () -> Void = {}) {

        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveLinear) {
            
            self.presentedViewAnchoredConstraints?.top?.constant = self.view.height + 50
            
            self.view.layoutIfNeeded()
            self.presentedView?.layoutIfNeeded()
            self.navigationController?.navigationBar.isHidden = false
            self.coordinator?.pop()

        } completion: { _ in
            self.presentedView?.removeFromSuperview()
            completion()
        }
    }
    
}
