//
//  UserDefaults.swift
//  iCinema
//
//  Created by Ahmed Yamany on 13/03/2023.
//

import Foundation

// A struct that manages saving and loading data to and from a Property List file in the app's Documents directory.
struct FilesManager {
    var filePath: String     // The name of the file that data will be saved to.
    var archiveURL: URL     // The full path to the file where data will be saved.

    // The app's Documents directory obtained using the FileManager class.
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    init(path: String) {
        self.filePath = path
        
        // The full path to the file is set by appending the file path to the Documents directory path and adding a .plist file extension.
        self.archiveURL = self.documentsDirectory.appendingPathComponent(self.filePath).appendingPathExtension("plist")
    }
    
    // Saves a given data to the Property List file.
    func save(_ data: any Codable) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(data)         // Encodes the data to Property List format.
        
        // Writes the encoded data to the specified file with file protection.
        try? codedToDos?.write(to: archiveURL, options: .completeFileProtection)
    }
    
    // Loads data of a specified type from the Property List file.
    func load<T: Decodable>(_ type: T.Type) -> T? {
        // Loads the data from the file at the specified URL.
        guard let codedData = try? Data(contentsOf: archiveURL) else
          {return nil}
    
        // Decodes the loaded data from Property List format.
        let propertyListDecoder = PropertyListDecoder()
        let decodedData =  try? propertyListDecoder.decode(type, from: codedData)
        
        return decodedData
    }
    
}

