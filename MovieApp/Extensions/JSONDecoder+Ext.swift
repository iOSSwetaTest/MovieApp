//
//  JSONDecoder+Ext.swift
//  CumberbatchApp
//
//  Created by shweta dodiya on 2024-08-13.
//

import Foundation
extension KeyedDecodingContainer {
    
    func decodeArray<T: Codable>(_ type: T.Type, forKey key: Key) -> [T] {
        if let array = try? self.decode([T].self, forKey: key) {
            return array
        } else {
            return []
        }
    }
    
    func decode<T: Decodable>(forKey key: Key, defaultValue: T) -> T {
        return (try? self.decode(T.self, forKey: key)) ?? defaultValue
    }
    
}
