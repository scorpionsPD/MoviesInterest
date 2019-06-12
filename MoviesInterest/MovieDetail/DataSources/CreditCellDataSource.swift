//
//  CreditCellDataSource.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 04/04/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

class CreditCellDataSource: NSObject {

    var creditArray:[SingleCredit]?
    
    init(singleCreditArray:[SingleCredit]?) {
        self.creditArray = singleCreditArray
    }
}

extension CreditCellDataSource: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.creditArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CastCollectionViewCell.self), for: indexPath) as! CastCollectionViewCell
        cell.item = self.creditArray![indexPath.item]
        return cell
    }
}
