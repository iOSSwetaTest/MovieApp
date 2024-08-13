//
//  SimilarMovie.swift
//  MovieApp
//
//  Created by shweta dodiya on 2024-08-13.
//

import Foundation

struct SimilarMovieList: Codable, Identifiable {
    
    var id: Int
    let results : [SimilarMovie]

    enum CodingKeys: String, CodingKey {
        case results = "results"
        case id = "page"

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = container.decodeArray(SimilarMovie.self, forKey: .results)
        self.id = try container.decode(Int.self, forKey: .id)
    }
    
}


struct SimilarMovie: Codable, Identifiable {
   
    let id: Int
    let title : String
    let poster_path : String?

    enum CodingKeys: String, CodingKey {
        case id
        case title = "title"
        case poster_path = "poster_path"
    }
    
    
}
