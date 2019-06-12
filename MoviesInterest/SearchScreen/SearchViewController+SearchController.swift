//
//  SearchViewController+SearchController.swift
//  SwipeDemo
//
//  Created by Pradeep Dahiya on 31/05/2019.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import Foundation
import UIKit

extension SearchViewController:UISearchControllerDelegate{
    
}
extension SearchViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        searchDelayTimer?.invalidate()
        searchDelayTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] _ in
            self?.loadMovies(forQuery: searchController.searchBar.text) { movies in
                self?.movies = movies
                //dself?.scrollToTopCell(withAnimation: false)
            }
        }
    }
}
