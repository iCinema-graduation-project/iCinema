//
//  AppSettings.swift
//  iCinema
//
//  Created by Ahmed Yamany on 02/05/2023.
//

import UIKit


class AppSettings {
    static let shared = AppSettings()
    
    func open() async -> Bool {
        // Create the URL that deep links to your app's custom settings.
        if let url = await URL(string: UIApplication.openSettingsURLString) {
            // Ask the system to open that URL.
            return await UIApplication.shared.open(url)
        }
        return false
    }

}
