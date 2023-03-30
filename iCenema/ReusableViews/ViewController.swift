//
//  ViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 09/03/2023.
//

import UIKit


class ViewController: UIViewController{
    // used to store properities when presenting view controller
    public var presenterViewController: ViewController?
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
    @objc public func presentViewController(_ viewControllerToPresent: ViewController, completion: @escaping () -> Void = {} ){
        viewControllerToPresent.presenterViewController = self

        // Set the presentedView property to the view of the view controller being presented.
        self.presentedView = viewControllerToPresent.view
        
        // Add the presentedView to the current view controller's view hierarchy
        guard let presentedView = self.presentedView else { return }
        self.view.addSubview(presentedView)
        presentedView.frame = self.view.bounds

        // Animate the presentation of the presentedView at 0 seconds.
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
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//
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
            
            self.presenterViewController?.presentedViewAnchoredConstraints?.top?.constant = self.view.height
            
            self.presenterViewController?.view.layoutIfNeeded()
            self.presenterViewController?.presentedView?.layoutIfNeeded()
            self.presenterViewController?.navigationController?.navigationBar.isHidden = false
            self.presenterViewController?.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            self.presenterViewController?.coordinator?.pop()

        } completion: { _ in
            self.presenterViewController?.presentedView?.removeFromSuperview()
            completion()
            self.presenterViewController?.presentedView = nil
        }
    }
}
