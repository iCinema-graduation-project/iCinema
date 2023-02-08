//
//  AppCoordinator.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/02/2023.
//

import UIKit

var isAuthed = true

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var coordinators: [ViewController.Type] = []
    
    init() {
        
        if isAuthed {
            self.navigationController = AuthFlowCoordinator().navigationController
        }else{
            navigationController = .init()
        }
        
    }
    
    func push() {
        
    }
    
    func pop() {
        
    }
    
}
