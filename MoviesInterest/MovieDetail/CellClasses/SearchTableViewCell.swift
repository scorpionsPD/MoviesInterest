//
//  SearchTableViewCell.swift
//  SwipeDemo
//
//  Created by Pradeep Dahiya on 31/05/2019.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    var item : Movie?{
        didSet{
            guard let item = item else {
                return
            }
            self.voteAverage.text = item.releaseDate?.stringFromDate ?? "" + "\(item.voteAverage)" + " / 10"
            self.mainImageView.image  = #imageLiteral(resourceName: "placeholder_poster")
            self.movieTitle.text = item.title
            if let posterPath = item.posterPath {
                downloadImage(from: Movie.posterUrl(from: posterPath, for: .small)) { (image) in
                    DispatchQueue.main.async {
                        self.mainImageView.image = image
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
