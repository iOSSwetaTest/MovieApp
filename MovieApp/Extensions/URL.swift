//
//  URL.swift
//  CumberbatchApp
//
//  Created by shweta dodiya on 2024-08-12.
//

import Foundation
extension URL {
    init?(apiPath: String) {
        self.init(string: "https://api.themoviedb.org/3/discover/\(apiPath)")
    }
}
