//  MovieHeaderCell.swift
//  ApiTest
//  Created by Pradeep Dahiya on 27/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.


import UIKit

class MovieHeaderCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var releasedate: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    var item: MovieViewModelItem? {
        didSet {
            guard let item = item as? MovieModelNamePictureItem else {
                return
            }
            downloadImage(from: Movie.posterUrl(from: item.pictureUrl, for: .small), completion: { (imageContent) in
                DispatchQueue.main.async {
                    self.moviePoster.image = imageContent
                }
            })
            self.movieName?.text = item.name
            self.movieGenre?.text = item.genre
            self.releasedate?.text = item.releaseDate
            self.movieOverview?.text = item.overView
            self.moviePoster?.image = UIImage(named: item.pictureUrl ?? "")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
