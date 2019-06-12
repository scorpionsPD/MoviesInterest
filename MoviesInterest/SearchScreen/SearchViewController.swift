//
//  SearchViewController.swift
//  SwipeDemo
//
//  Created by Pradeep Dahiya on 31/05/2019.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    var selectedMovie: Movie?
    var currentPage: Int?
    var totalResults: Int?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchDataSource: SearchScreenDataSource?
    
    lazy var resultSearchController: SearchController = {
        let resultSearchController = SearchController(searchResultsController: nil)
        resultSearchController.searchResultsUpdater = self
        resultSearchController.delegate = self
        return resultSearchController
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchDelayTimer: Timer?
    
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.searchDataSource = SearchScreenDataSource(movieList: self.movies)
                self.tableView.dataSource = self.searchDataSource
                self.tableView.reloadData()
                self.updateUI()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Search Movies"
        
        let nibHeader = UINib.init(nibName: String(describing: SearchTableViewCell.self), bundle: nil)
        tableView.register(nibHeader, forCellReuseIdentifier: String(describing: SearchTableViewCell.self))
        
        self.tableView.delegate = self
        
        configureSearchController()
        
        updateUI()
    }
    
    func configureSearchController() {
        if #available(iOS 11.0, *) {
            navigationItem.searchController = resultSearchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = resultSearchController.searchBar
        }
        
        definesPresentationContext = true
    }
    
    func scrollToTopCell(withAnimation: Bool) {
        guard !movies.isEmpty else { return }
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.scrollToRow(at: indexPath,
                                       at: .top,
                                       animated: withAnimation)
        }
    }
    
    func updateUI() {
        tableView.reloadData()
        
        if movies.isEmpty {
            tableView.tableFooterView = UIView()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ob = MovieDetailPage(movie: movies[indexPath.row])
        self.navigationController?.pushViewController(ob, animated: true)
    }
}
