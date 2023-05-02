//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 13/04/2023.
//

import UIKit
import MakeConstraints

open class CoordinatorViewController: UIViewController{

    public private(set) var presenterViewController: CoordinatorViewController? = nil
    public private(set) weak var presentedView:  UIView? = nil
    public var presentedViewAnchoredConstraints: AnchoredConstraints? = nil
    
    // the coordinator is responsible for managing navigation between view controllers.
    public var coordinator: Coordinator?
    public var coordinationType: CoordinationTypes = .navigation
    
    public var userInfo: [String: Any]? = nil
    
    // used to notify the coordinator when the view controller is popped from the navigation stack.
    open override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        if parent == nil {
            self.coordinator?.pop()
        }
    }

}

extension CoordinatorViewController {
    /// This Method presents the given view controller on top of the current view controller.
    @objc public func presentViewController(_ viewControllerToPresent: CoordinatorViewController, completion: @escaping () -> Void = {} ){
        viewControllerToPresent.presenterViewController = self
        
        // Set the presentedView property to the view of the view controller being presented.
        self.presentedView = viewControllerToPresent.view
        
        // Add the presentedView to the current view controller's view hierarchy
        guard let presentedView = self.presentedView else { return }
        self.view.addSubview(presentedView)
        presentedView.frame = self.view.bounds

        // Animate the presentation of the presentedView at 0 seconds.
        UIView.animate(withDuration: 0, delay: 0) {
            
            presentedView.fillXSuperViewConstraints()
                        
            presentedView.makeConstraints(
                                        bottomAnchor: self.view.bottomAnchor)

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
                       options: .curveEaseInOut) {

            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

            self.presentedViewAnchoredConstraints = presentedView.makeConstraints(topAnchor: self.view.topAnchor,
                                                                                  bottomAnchor: self.view.bottomAnchor)

            
            self.view.layoutIfNeeded()
            presentedView.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
    
    @objc public func dismiss(completion: @escaping () -> Void = {}) {
        self.presenterViewController?.navigationController?.navigationBar.isHidden = false
        self.presenterViewController?.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.7,
                       options: .curveLinear) {
            
            self.presenterViewController?.presentedViewAnchoredConstraints?.top?.constant = self.view.height
            
            self.presenterViewController?.view.layoutIfNeeded()
            self.presenterViewController?.presentedView?.layoutIfNeeded()
            
        } completion: { _ in
            self.presenterViewController?.presentedView?.removeFromSuperview()
            self.presenterViewController?.presentedView = nil
            completion()
        }
    }
    


}
