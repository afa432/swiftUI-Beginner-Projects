//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Ahmet Faruk Arvas on 20.01.2024.
//

import Foundation

extension Bundle{
    func decode<T: Codable>(_ file: String)-> T{
        
        // this guard is making sure that url is founded
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("\(file) Cannot Be founded in bundle.")
        }
        
        
        // this guard is making sure that Astronaouts datas safely imported in 'data'
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Data's in \(file) cannot be founded in bundle.")
        }
        
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        // this guard is making sure that Astronaouts data is decoded in loaded
        guard let loaded = try? decoder.decode(T.self, from: data)else {
            fatalError("Failed to decode \(file) from Bundle")
        }
        
        //loaded is a dictionary which contains astronauts data
        return loaded
        
    }
}
