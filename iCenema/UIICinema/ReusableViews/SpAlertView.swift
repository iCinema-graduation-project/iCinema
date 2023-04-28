//
//  AlertView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/04/2023.
//

import SPAlert
import Foundation

class SPAlert {
    
    static func showAlert(with message: String, duration: TimeInterval = 4) {
        let alertView = SPAlertView(message: message)
        alertView.duration = duration
        alertView.present()
    }
    
    static func showUnKnownError() {
        SPAlert.showAlert(with: "Unkown Error Occurred")
    }
    
}

