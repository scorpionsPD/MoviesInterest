//
//  CastCrewTableViewCell.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 29/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class CastCrewTableViewCell: UITableViewCell {

    @IBOutlet weak var creditsCollectionView: UICollectionView!
    
    var creditCellDataSource: CreditCellDataSource?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nib = UINib(nibName: String(describing: CastCollectionViewCell.self), bundle: nil)
        self.creditsCollectionView.register(nib, forCellWithReuseIdentifier: String(describing: CastCollectionViewCell.self))
    }

    var item : [SingleCredit]? {
        didSet{
            self.creditCellDataSource = CreditCellDataSource(singleCreditArray: item)
            self.creditsCollectionView.dataSource = self.creditCellDataSource
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
