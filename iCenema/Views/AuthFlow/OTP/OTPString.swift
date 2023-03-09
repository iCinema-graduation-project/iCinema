//
//  Model.swift
//  iCinema
//
//  Created by Ahmed Yamany on 12/02/2023.
//

import Foundation


struct OTPString {
    let count: Int
    var isEmpty: Bool = true
    
    lazy var code: String = "" {
        didSet {
            self.isEmpty = code.count != count
        }
    }
    
    mutating func add(charachter: String, at index: Int) {
        let charachter = Character(charachter)
        let stringIndex = code.index(code.startIndex, offsetBy: index)
        code.insert(charachter, at: stringIndex)
    }
    
    mutating func removeCharachter(at index: Int){
        let stringIndex = code.index(code.startIndex, offsetBy: index)
        code.remove(at: stringIndex)
    }
    
}
