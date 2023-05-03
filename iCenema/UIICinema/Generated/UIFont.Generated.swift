//
//  FontManager.swift
//  iCinema
//
//  Created by Ahmed Yamany on 30/01/2023.
//

import UIKit.UIFont
import SwiftUI

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

let fontName = "Stolzl"

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
        return UIFont(name: "Stolzl-Medium", size: 12)!
    }

    static var footnote: UIFont {
        return UIFont(name: "Stolzl-Bold", size: 14)!
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


public extension Font {
    static let custom = Custom.self
    
    struct Custom {
        static var button: Font { return Font(UIFont.button) }

        static var smallButton: Font { return Font(UIFont.smallButton) }
        
        static var title1: Font {
            return Font(UIFont.title1)
        }

        static var title2: Font {
            return Font(UIFont.title2)
        }

        static var title3: Font {
            return Font(UIFont.title3)
        }

        static var callout: Font {
            return Font(UIFont.callout)
        }

        static var footnote: Font {
            return Font(UIFont.footnote)
        }

        static var body: Font {
            return Font(UIFont.body)
        }

        static var caption1: Font {
            return Font(UIFont.caption1)
        }
        static var caption2: Font {
            return Font(UIFont.caption2)
        }
        
        static var textfeild: Font {
            return Font(UIFont.textfeild)
        }

    }
}
