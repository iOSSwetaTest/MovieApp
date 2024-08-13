//
//  MockJson.swift
//  CumberbatchApp
//
//  Created by shweta dodiya on 2024-08-13.
//

import Foundation

enum MockJson: String {
    case movieList = "listOfMovies"
    case movieDetail = "detailsAboutMovie"
    case similarMoviesList = "listSimilarMovies"

}

extension MockJson {
    
    private func generate<C: Codable>(ofType type: C.Type) -> C? {
        Helper.loadJson(fileName: self.rawValue, type: type)
    }
    
}

extension MockJson {
    
    static func fetchMovieList() -> MovieList? {
        MockJson.movieList.generate(ofType: MovieList.self) ?? nil
    }
    
    static func getMovieDetails(accountId: Int) -> MovieDetail? {
        MockJson.movieDetail.generate(ofType: MovieDetail.self) ?? nil
    }
    
    static func fetchSimilarMovieList() -> SimilarMovieList? {
        MockJson.similarMoviesList.generate(ofType: SimilarMovieList.self) ?? nil
    }
}


