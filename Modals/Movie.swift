//
//  Movie.swift
//  SwipeDemo
//
//  Created by Pradeep Dahiya on 17/05/2019.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//


import UIKit
import CoreData

class Movie: Codable {
    let id: Int64
    let title: String?
    let voteAverage: Double
    let voteCount: Double
    let posterPath: String?
    let overview: String
    let runtime: Int16
    let genreIDS: [Int]?
//    let originalLanguage: String?
    
    var releaseDate: Date?
    var poster: UIImage?

    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case overview
        case runtime
        case genreIDS = "genre_ids"
        case releaseDate = "release_date"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int64.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        
        //originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
            ?? 0

        voteCount = try container.decodeIfPresent(Double.self, forKey: .voteCount)
            ?? 0

        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        overview = try container.decode(String.self, forKey: .overview)

        runtime = try container.decodeIfPresent(Int16.self, forKey: .runtime)
            ?? 0

        genreIDS = try container.decodeIfPresent([Int].self, forKey: .genreIDS) ?? []
        
        let dateString = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        releaseDate = dateString?.dateFromString
    }

    // This is only for creating a movie to use it with the webservice
    init(id: Int64, title: String) {
        self.id = id
        self.title = title
        voteAverage = 0
        voteCount = 0
        overview = ""
        runtime = 0
        posterPath = nil
        genreIDS = []
       // originalLanguage = nil
    }
    
    func genreString() -> String {
        var genreStr = String()
        for item in self.genreIDS! {
            let genreString = String(describing: getGenreString(rawValue: item))
            genreStr.append(genreString)
            genreStr.append("/")
        }
        return String(genreStr.dropLast())
    }
}



//struct Welcome: Codable {
//    let results: [Result]
//    let page, totalResults: Int
//    let dates: Dates
//    let totalPages: Int
//
//    enum CodingKeys: String, CodingKey {
//        case results, page
//        case totalResults = "total_results"
//        case dates
//        case totalPages = "total_pages"
//    }
//}
//
//// MARK: - Dates
//struct Dates: Codable {
//    let maximum, minimum: String
//}
//
//// MARK: - Result
//struct Result: Codable {
//    let voteCount, id: Int
//    let video: Bool
//    let voteAverage: Double
//    let title: String
//    let popularity: Double
//    let posterPath: String
//    let originalLanguage: OriginalLanguage
//    let originalTitle: String
//    let genreIDS: [Int]
//    let backdropPath: String
//    let adult: Bool
//    let overview, releaseDate: String
//
//    enum CodingKeys: String, CodingKey {
//        case voteCount = "vote_count"
//        case id, video
//        case voteAverage = "vote_average"
//        case title, popularity
//        case posterPath = "poster_path"
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case genreIDS = "genre_ids"
//        case backdropPath = "backdrop_path"
//        case adult, overview
//        case releaseDate = "release_date"
//    }
//}
//
//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case ja = "ja"
//}
