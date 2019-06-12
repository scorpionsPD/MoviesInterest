//
//  PagedMovieResult.swift
//  
//
//  Created by Pradeep Dahiya on 22.10.17.
//  Copyright © 2017 Pradeep Dahiya. All rights reserved.
//

struct PagedMovieResult: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
