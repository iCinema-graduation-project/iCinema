//
//  navigationBar+convertToICinema.swift
//  iCinema
//
//  Created by Ahmed Yamany on 12/04/2023.
//

import UIKit


extension UINavigationBar {
    func convertToICinema() {
        prefersLargeTitles = true
        largeTitleTextAttributes = [.foregroundColor: UIColor.iCinemaYellowColor, .font: UIFont.title1]
        titleTextAttributes = [.foregroundColor: UIColor.iCinemaYellowColor, .font: UIFont.title3]
    }
}
