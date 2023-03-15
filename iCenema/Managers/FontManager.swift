//
//  FontManager.swift
//  iCinema
//
//  Created by Ahmed Yamany on 30/01/2023.
//

import UIKit

/*
 Stolzl
 -- Stolzl-Regular
 -- Stolzl-Book
 -- Stolzl-Thin
 -- Stolzl-Light
 -- Stolzl-Medium
 -- Stolzl-Bold
 
 for familyName in UIFont.familyNames {
     print (familyName )
     for fontName in UIFont.fontNames (forFamilyName: familyName) {
         print("-- \(fontName)")
     }
 }

 */

// MARK: - Buttons
public extension UIFont {

    static var button: UIFont {
        return UIFont(name: "Stolzl-Medium", size: 16)!
    }

    static var smallButton: UIFont {
        return UIFont(name: "Stolzl-Medium", size: 12)!
    }
}

// MARK: - labels

public extension UIFont {

    static var title1: UIFont {
        return UIFont(name: "Stolzl-Bold", size: 26)!
    }

    static var title2: UIFont {
        return UIFont(name: "Stolzl-Bold", size: 24)!
    }

    static var title3: UIFont {
        return UIFont(name: "Stolzl-Medium", size: 18)!
    }

    static var callout: UIFont {
        return UIFont(name: "Stolzl-Medium", size: 16)!
    }

    static var footnote: UIFont {
        return UIFont(name: "Stolzl-Bold", size: 12)!
    }

    static var body: UIFont {
        return UIFont(name: "Stolzl-Regular", size: 12)!
    }

    static var caption1: UIFont {
        return UIFont(name: "Stolzl-Regular", size: 10)!
    }
    static var caption2: UIFont {
        return UIFont(name: "Stolzl-Regular", size: 8)!
    }
}


// MARK: - TextField

public extension UIFont {

    static var textfeild: UIFont {
        return UIFont(name: "Stolzl-Medium", size: 18)!
    }
}
