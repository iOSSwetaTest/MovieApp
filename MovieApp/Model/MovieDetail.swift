//
//  MovieDetail.swift
//  CumberbatchApp
//
//  Created by shweta dodiya on 2024-08-13.
//

import Foundation

struct MovieDetail: Codable, Identifiable {
    
    var id: Int
    let title : String
    let poster_path : String?
    let overview : String
    
    enum CodingKeys: String, CodingKey {
        case title = "name"
        case overview = "overview"
        case poster_path = "poster_path"
        case id

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.poster_path = try container.decode(String.self, forKey: .poster_path)

    }
    
}

