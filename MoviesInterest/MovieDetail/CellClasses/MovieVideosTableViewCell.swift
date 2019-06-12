//
//  MovieVideosTableViewCell.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 29/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView


struct MovieVideo {
    let name: String
    let key: String
}

class MovieVideosTableViewCell: UITableViewCell,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var videosCollectionView: UICollectionView!
    // @IBOutlet weak var videoPreview: WKYTPlayerView!
    
   // @IBOutlet weak var videoTitle: UILabel!
    var videoCellDataSource: VideoCellDataSource?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: String(describing: VideoCollectionViewCell.self), bundle: nil)
        self.videosCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: VideoCollectionViewCell.self))
    }
    
    var item : [MovieVideo]? {
        didSet{
            self.videoCellDataSource = VideoCellDataSource(singleVideoArray: item)
            self.videosCollectionView.dataSource = self.videoCellDataSource
            self.videosCollectionView.delegate = self
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.width / 2)
        
    }
//    var item: MovieVideo? {
//        didSet{
//            guard let item = item else {
//                return
//            }
//            //self.videoPreview.load(withVideoId: item.key)
//           // self.videoTitle.text = item.name
//        }
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
