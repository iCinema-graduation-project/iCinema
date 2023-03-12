//
//  FontManager.swift
//  iCinema
//
//  Created by Ahmed Yamany on 30/01/2023.
//

import UIKit

/*
 Sono Monospace
 -- SonoMonospace-Regular
 -- SonoMonospace-ExtraLight
 -- SonoMonospace-Light
 -- SonoMonospace-Medium
 -- SonoMonospace-SemiBold
 -- SonoMonospace-Bold
 -- SonoMonospace-ExtraBold
 */

// MARK: - Buttons
public extension UIFont {

    static var button: UIFont {
        return UIFont(name: "SonoMonospace-Medium", size: 16)!
    }

    static var smallButton: UIFont {
        return UIFont(name: "SonoMonospace-Medium", size: 12)!
    }
}

// MARK: - labels

public extension UIFont {

    static var title1: UIFont {
        return UIFont(name: "SonoMonospace-Bold", size: 26)!
    }

    static var title2: UIFont {
        return UIFont(name: "SonoMonospace-Bold", size: 24)!
    }

    static var title3: UIFont {
        return UIFont(name: "SonoMonospace-Medium", size: 18)!
    }

    static var callout: UIFont {
        return UIFont(name: "SonoMonospace-Medium", size: 16)!
    }

    static var footnote: UIFont {
        return UIFont(name: "SonoMonospace-Bold", size: 12)!
    }

    static var body: UIFont {
        return UIFont(name: "SonoMonospace-Regular", size: 12)!
    }

    static var caption1: UIFont {
        return UIFont(name: "SonoMonospace-Regular", size: 10)!
    }
    static var caption2: UIFont {
        return UIFont(name: "SonoMonospace-Regular", size: 8)!
    }
}


// MARK: - TextField

public extension UIFont {

    static var textfeild: UIFont {
        return UIFont(name: "SonoMonospace-Medium", size: 18)!
    }
}
