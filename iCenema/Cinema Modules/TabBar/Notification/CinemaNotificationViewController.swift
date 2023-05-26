//
//  CinemaNotificationViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/05/2023.
//

import UIKit

final class CinemaNotificationViewController: ICinemaViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TabBarViewModel.shared.selectedTabIndex = 1
    }
}

