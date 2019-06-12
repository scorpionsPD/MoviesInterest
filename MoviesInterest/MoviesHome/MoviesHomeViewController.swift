//
//  MoviesHomeViewController.swift
//  SwipeDemo
//
//  Created by Pradeep Dahiya on 17/05/2019.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit


class MoviesHomeViewController: UIViewController {

    var moviesDataSource:HomeScreenDataSource?
    var delegate: HomeScreenDelegates?
    var swipeView:SwipableView?
    
    var selectedMovie: Movie?
    var currentPage: Int?
    var totalResults: Int?
    
    //Side More Item
    var sideMenubarLeft:SideMenubar!
    var arrBtnImageListLeft = [SideMenuImageList]()
    
    var movies: [Movie] = [] {
        didSet {
            DispatchQueue.main.sync {
                let dataSource = HomeScreenDataSource(movieList: self.movies)
                self.swipeView!.dataSource = dataSource
                self.swipeView!.delegate = self
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !Reachability.isConnectedToNetwork() {
            self.showAlert(withMessage: Alert.connectionError)
        }

        swipeView = SwipableView(frame: self.view.frame)
        self.view.addSubview(self.swipeView!)
        loadMovies(category: .now_playing) { [weak self] movies in
            self?.movies = movies
        }
        //MARK: Side Menu Initialisation
        setupSideMenu()
        
        //MARK: Title set
        self.title = String(describing: NavigationTitle.init(rawValue: 0)).uppercased()
    }
    //MARK: Navigation button Actions
    @IBAction func menuPressed(_ sender: Any) {
        if !sideMenubarLeft.isShowingMenuBar {
            sideMenubarLeft.show(isShowingLeftToRight: true)
        } else { sideMenubarLeft.hide()}
        
    }
    @IBAction func searchPressed(_ sender: Any) {
        perform(segue: .showSearch, sender: nil)
    }
}
extension MoviesHomeViewController: SwipableViewDelegate{
    func swipableViewCurrentItemIndexDidChange(_ swipableView: SwipableView?) {
        
    }
    func swipableView(_ swipableView: SwipableView?, didSelectItemAt index: Int) {
        let ob = MovieDetailPage(movie: movies[(swipableView?.currentItemIndex)!])
        self.navigationController?.pushViewController(ob, animated: true)
    }
    func swipeDownFinished(_ swipableView: SwipableView?) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        sideMenubarLeft.hide()
    }
    func swipeUPFinished(_ swipableView: SwipableView?) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        sideMenubarLeft.hide()
    }
}
