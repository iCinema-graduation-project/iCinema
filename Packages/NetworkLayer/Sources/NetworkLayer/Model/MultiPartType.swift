//
//  File.swift
//  
//
//  Created by Ahmed Yamany on 30/04/2023.
//

import Foundation

/// To Represent different file types
public enum FilesTypes: String, CaseIterable {
    case file
    case image
    case video
}

/// To represent a file as multipart data
public struct MultiPartType {
    
    /// The type of the file (as defined in the enum)
    let type: FilesTypes
    
    /// The file extension (e.g. "png", "mp4")
    let extention: String
    
    /// The actual file data as a `Data` object
    let data: Data

    
    public init(type: FilesTypes, extention: String, data: Data) {
        self.type = type
        self.extention = extention
        self.data = data
    }
    
}
