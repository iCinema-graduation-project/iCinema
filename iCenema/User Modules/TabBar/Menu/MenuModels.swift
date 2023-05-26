//
//  MenuModels.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/03/2023.
//

import UIKit

struct MenuCell {
    let id = UUID()
    let imageSystemName: String
    let text: String
    //    var viewController: Any
    let action: () -> Void
    
    
    init(imageSystemName: String, text: String, action: @escaping () -> Void) {
        self.imageSystemName = imageSystemName
        self.text = text
        self.action = action
    }
    
}
struct MenuSection {
    let id = UUID()
    let title: String
    let cells: [MenuCell]
}
