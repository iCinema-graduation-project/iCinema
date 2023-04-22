//
//  LanguageViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 15/04/2023.
//

import UIKit


final class LanguageViewController: ICinemaViewController {
    
    override func viewDidLoad() {
        navigationController?.popViewController(animated: false)
        Task {
            let opened = await openSettings()
            print(opened)
        }
    }
    
    func openSettings() async -> Bool {
        // Create the URL that deep links to your app's custom settings.
        if let url = URL(string: UIApplication.openSettingsURLString) {
            // Ask the system to open that URL.
            return await UIApplication.shared.open(url)
        }
        return false
    }
}
