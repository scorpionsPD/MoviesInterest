//
//  CastCollectionViewCell.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 04/04/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    
    var item : SingleCredit? {
        didSet{
            guard let item = item else {
                return
            }
            downloadImage(from: Movie.posterUrl(from: item.image, for: .small), completion: { (imageContent) in
                DispatchQueue.main.async {
                    self.profileImage.image = imageContent
                }
            })
            self.name.text = item.realName + " as " + item.charecterName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
