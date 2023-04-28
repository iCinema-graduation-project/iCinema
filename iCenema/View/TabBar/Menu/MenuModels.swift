//
//  MenuModels.swift
//  iCinema
//
//  Created by Ahmed Yamany on 25/03/2023.
//

import UIKit

class MenuCell {
    let id = UUID()
    let imageSystemName: String
    let text: String
    var viewController: Any
    
    init(imageSystemName: String, text: String, viewController: Any) {
        self.imageSystemName = imageSystemName
        self.text = text
        self.viewController = viewController
    }
    
    static func == (lhs: MenuCell, rhs: MenuCell) -> Bool {
        lhs.id == rhs.id
    }
}
struct MenuSection {
    let id = UUID()
    let title: String
    let cells: [MenuCell]
}
