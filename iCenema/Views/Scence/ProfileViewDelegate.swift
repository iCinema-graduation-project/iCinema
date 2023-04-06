//
//  ProfileViewDelegate.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/03/2023.
//

import SwiftUI
import UIKit

protocol ProfileViewDelegate: ObservableObject {
    var dismissAction: (() -> Void) { get set }
}
