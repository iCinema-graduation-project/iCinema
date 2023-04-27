//
//  HomeCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 24/02/2023.
//

import UIKit
import Coordinator

final class HomeCoordinator: Coordinator {
 /*
    The HomeCoordinator is responsible for booking
    to access booking to have to first present movie or cinema Profile
    that requiers to hide the presenterViewController navigationController's navigationBar
    but when poping to the homeViewController mush view it
 */
    override init() {
        super.init()
        setViewControllers([HomeViewController.self, CinemaDateViewController.self,
                            SelectHallViewController.self, CinemaChairsViewController.self,
                            PaymentMethodViewController.self, BookingSuccessViewController.self])
    }
    
    
    override func push(userInfo: [String : Any]? = nil) {
        super.push(userInfo: userInfo)
        
        /// Make sure that navigationController's navigationBar is not hiden
        self.navigationController.navigationBar.isHidden = false
        self.navigationController.interactivePopGestureRecognizer?.isEnabled = true
    
    }
    
    override func pop() {
        /// whene comming back from the booking
        if currentIndex == 1 {
            /// check if the presented view is not nil
            if let visibleViewController = navigationController.visibleViewController as? ICinemaViewController,
               visibleViewController.presentedView != nil {
                /// if that true hide the navigationController's navigationBar
                self.navigationController.navigationBar.isHidden = true
                self.navigationController.interactivePopGestureRecognizer?.isEnabled = false
            }
        }
        
        super.pop()

    }
    
}
