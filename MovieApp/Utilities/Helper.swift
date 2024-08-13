//
//  Helper.swift
//  CumberbatchApp
//
//  Created by shweta dodiya on 2024-08-13.
//

import Foundation
class Helper {
    static func loadJson<T: Codable>(fileName: String, type: T.Type) -> T? {
        if let data = getDataFromJson(fileName: fileName) {
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    static func getDataFromJson(fileName: String) -> Data? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                return try Data(contentsOf: url)
            } catch {
                print("error:\(error)")
                return nil
            }
        } else {
            return nil
        }
    }
}

extension Data {
    func getJsonObject<T>(of type: T.Type) -> T? {
        do {
            let info = try JSONSerialization.jsonObject(with: self) as? T
            return info
        } catch {
            return nil
        }
    }
}
