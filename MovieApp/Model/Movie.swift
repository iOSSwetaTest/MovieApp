//
//  Movie.swift
//  CumberbatchApp
//
//  Created by shweta dodiya on 2024-08-12.
//

import Foundation

struct MovieList: Codable, Identifiable {
    
    var id: Int
    let results : [Movie]

    enum CodingKeys: String, CodingKey {
        case results = "results"
        case id = "page"

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = container.decodeArray(Movie.self, forKey: .results)
        self.id = try container.decode(Int.self, forKey: .id)

    }
    
}


struct Movie: Codable, Identifiable {
   
    let id: Int
    let name : String
    let poster_path : String?

    enum CodingKeys: String, CodingKey {
        case id
        case name = "name"
        case poster_path = "poster_path"
    }
    
    
}
