//
//  +hostigView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/03/2023.
//

import SwiftUI
import UIKit

extension View {
    func hostigView() -> UIView {
        return UIHostingController(rootView: self).view!
    }
}
