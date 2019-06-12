//
//  MoviesHomeViewController+Webservice.swift
//  SwipeDemo
//
//  Created by Pradeep Dahiya on 17/05/2019.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import Foundation

extension MoviesHomeViewController{
    
    func loadMovies(nextPage: Bool = false,category:Category, completion: @escaping ([Movie]) -> Void) {
        var pageToLoad = 1
        if let page = currentPage, nextPage {
            pageToLoad = page + 1
        }
        
        let resource: Resource<PagedMovieResult>?
        resource = Movie.moviesInTheater(page: pageToLoad, cat: category)
        
        Webservice.load(resource: resource) { result in
            switch result {
            case .failure:
                //self.showAlert(withMessage: Alert.loadingDataError)
                completion([])
            case .success(let result):
                self.currentPage = result.page
                self.totalResults = result.totalResults
                completion(result.results)
            }
        }
    }
}
