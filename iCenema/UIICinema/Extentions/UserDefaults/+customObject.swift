//
//  +sa.swift
//  iCinema
//
//  Created by Ahmed Yamany on 13/03/2023.
//

import Foundation

extension UserDefaults {
    
    enum Keys: String, CaseIterable{
        case user = "User"
    }
    
   func save(customObject object: some Encodable, inKey key: Keys) {
       let encoder = JSONEncoder()
       if let encoded = try? encoder.encode(object) {
           self.set(encoded, forKey: key.rawValue)
       }
   }

   func load<T:Decodable>(object type: T.Type, fromKey key: Keys) -> T? {
       if let data = self.data(forKey: key.rawValue) {
           let decoder = JSONDecoder()
           if let object = try? decoder.decode(type, from: data) {
               return object
           }else {
               print("Couldnt decode object")
               return nil
           }
       }else {
           print("Couldnt find key")
           return nil
       }
   }
    
    func reset(_ completion: @escaping () -> Void) {
        Keys.allCases.forEach { removeObject(forKey: $0.rawValue) }
        completion()
    }

}
