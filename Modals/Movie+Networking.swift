//
//  Movie+Networking.swift
//  
//
//  Created by Pradeep Dahiya on 10.07.18.
//  Copyright © 2018 Pradeep Dahiya. All rights reserved.
//

import UIKit

extension Movie {
    
    fileprivate static let apiKey = ApiKeyStore.theMovieDbKey

    static func search(withQuery query: String, page: Int) -> Resource<PagedMovieResult>? {
        guard let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
            return nil
        }
        let urlAsString = "\(Constants.Backend.url)/search/movie" +
            "?language=\(String.languageFormattedForTMDb)" +
            "&api_key=\(apiKey)" +
            "&query=\(escapedQuery)" +
            "&region=\(String.regionIso31661)" +
            "&with_release_type=3" +
        "&page=\(page)"
        
        return Resource(url: urlAsString, method: .get) { data in
            do {
                let paginatedMovies = try JSONDecoder()
                    .decode(PagedMovieResult.self, from: data)
                return paginatedMovies
            } catch {
                print(error)
                return nil
            }
        }
    }
    
    static func moviesInTheater(page: Int, cat:Category) -> Resource<PagedMovieResult>? {
        
        let urlAsString = "\(Constants.Backend.url)/movie/\(cat)" +
            "?api_key=\(apiKey)" + "&region=\(String.regionIso31661)"
        
        return Resource(url: urlAsString, method: .get) { data in
            do {
                let paginatedMovies = try JSONDecoder()
                    .decode(PagedMovieResult.self, from: data)
                return paginatedMovies
            } catch {
                print(error)
                return nil
            }
        }
    }

    static func posterUrl(from posterPath: String?, for size: Constants.PosterSize) -> URL {
        let urlAsString = "\(size.address)\(posterPath ?? "")?api_key=\(apiKey)"
        guard let url = URL(string: urlAsString) else {
            fatalError("Could not create url for poster download")
        }
        return url
    }
    
    var getDetails: Resource<MovieDetail> {
        let urlAsString = "\(Constants.Backend.url)/movie/\(id)" + "&api_key=\(Movie.apiKey)"

        return Resource(url: urlAsString, method: .get) { data in
            do {
                let decoder = JSONDecoder()
                let movieDetail = try decoder.decode(MovieDetail.self, from: data)
                return movieDetail
            } catch {
                print(error)
                return nil
            }
        }
    }
    
    var getVideos: Resource<MovieVideos> {
        let urlAsString = "\(Constants.Backend.url)/movie/\(id)/videos" + "?api_key=\(Movie.apiKey)"
        
        return Resource(url: urlAsString, method: .get) { data in
            do {
                let decoder = JSONDecoder()
                let movieVideos = try decoder.decode(MovieVideos.self, from: data)
                return movieVideos
            } catch {
                print(error)
                return nil
            }
        }
    }
    
    var getCredits: Resource<MovieCredits> {
        let urlAsString = "\(Constants.Backend.url)/movie/\(id)/credits" + "?api_key=\(Movie.apiKey)"
        
        return Resource(url: urlAsString, method: .get) { data in
            do {
                let decoder = JSONDecoder()
                let movieCredits = try decoder.decode(MovieCredits.self, from: data)
                return movieCredits
            } catch {
                print(error)
                return nil
            }
        }
    }
    
}
