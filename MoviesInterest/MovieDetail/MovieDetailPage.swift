//
//  MovieDetailPage.swift
//  SwipeDemo
//
//  Created by Pradeep Dahiya on 20/05/2019.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class MovieDetailPage: UIViewController {

    var dataSource:DetailDataSource?

    var detailsTableView:UITableView = {
        
        let table = UITableView()
        table.frame = CGRect(x: 0, y:0, width: MAX_WIDTH, height: MAX_HEIGHT)
        
        table.separatorStyle = .none
        table.autoresizesSubviews = false
        table.backgroundColor = UIColor.black
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 44
        
        let nibHeader = UINib.init(nibName: String(describing: MovieHeaderCell.self), bundle: nil)
        table.register(nibHeader, forCellReuseIdentifier: String(describing: MovieHeaderCell.self))
        
        let nibVideos = UINib.init(nibName: String(describing: MovieVideosTableViewCell.self), bundle: nil)
        table.register(nibVideos, forCellReuseIdentifier: String(describing: MovieVideosTableViewCell.self))
        
        let nibCasting = UINib.init(nibName: String(describing: CastCrewTableViewCell.self), bundle: nil)
        table.register(nibCasting, forCellReuseIdentifier: String(describing: CastCrewTableViewCell.self))
        
        return table
    }()
    
    var ratingScore: UIButton = {
        let rating = UIButton()
        rating.tintColor = UIColor.green
        rating.setImage(#imageLiteral(resourceName: "ratingIcon"), for: .normal)
        rating.translatesAutoresizingMaskIntoConstraints = false
        return rating
    }()
    
    var selectedMovie:Movie!{
        
        didSet{
            
            self.view.addSubview(self.detailsTableView)
            self.view.isUserInteractionEnabled = false
            guard let movie = selectedMovie else {return}
            loadVideoDetail(movie: movie) { (videos) in
                self.loadCreditsDetail(movie: movie, completion: { (credits) in
                    let complete = CompleteMovieDetailModal(movieDetail: movie, movieVideos: videos, credits: credits)
                    self.dataSource = DetailDataSource(data: complete)
                    DispatchQueue.main.async {
                        self.detailsTableView.dataSource = self.dataSource
                        self.detailsTableView.reloadData()
                        self.view.isUserInteractionEnabled = true
                    }
                })
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = selectedMovie.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.ratingScore)
        self.ratingScore.setTitle(String(selectedMovie.voteAverage), for: .normal)
    }
    
    init(movie: Movie) {
        super .init(nibName: nil, bundle: nil)
        setSelectedMovie(movie: movie)
    }
    
    func setSelectedMovie(movie: Movie) {
        self.selectedMovie = movie
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
