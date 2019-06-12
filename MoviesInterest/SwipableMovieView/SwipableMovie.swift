//
//  SwipableMovie.swift
//  MoviesInterest
//
//  Created by Pradeep Dahiya on 12/06/2019.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class SwipableMovie: UIView {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    
    @IBOutlet weak var voteAverage: UILabel!
    
    var item : Movie?{
        didSet{
            guard let item = item else {
                return
            }
            self.voteAverage.text = "\(item.voteAverage)" + " / 10"
            self.mainImageView.image  = #imageLiteral(resourceName: "placeholder_poster")
            self.movieTitle.text = item.title
            downloadImage(from: Movie.posterUrl(from: item.posterPath, for: .small)) { (image) in
                guard let downloadedImage = image else {
                    return
                }
                DispatchQueue.main.async {
                    self.mainImageView.image = downloadedImage
                    self.movieDescription.text = item.overview
                }
            }
        }
    }
}
