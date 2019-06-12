//
//  HomeScreenDataSource.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 01/04/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

struct SingleMovie {
    let image: String
    let origTitle: String
    let movieID: Int
}

class HomeScreenDataSource: NSObject {
    var movieArray = Array<Movie>()
    init(movieList:[Movie]?) {
        
        self.movieArray = movieList!
    }
}

class HomeScreenDelegates: NSObject {
    var movieArray = Array<Movie>()
    init(movieList:[Movie]?) {
        self.movieArray = movieList!
    }
}

extension HomeScreenDataSource: SwipableViewDataSource{
    func numberOfItems(in swipableView: SwipableView?) -> Int {
        return movieArray.count
    }
    
    func swipableView(_ swipableView: SwipableView?, viewForItemAt index: Int, reusing view: UIView?) -> UIView? {
        if index < 0 || index >= movieArray.count {
            return nil
        }
        var temp: UIView?
        if (view != nil) {
            print("reusing view")
            temp = view
        } else {
            temp = Bundle.main.loadNibNamed("SwipableMovie", owner: self, options: nil)?[0] as? UIView
            temp?.frame = CGRect(x: 0, y: 0, width: swipableView!.frame.size.width, height: swipableView!.frame.size.height)
        }
        let v = temp as? SwipableMovie
        v?.item = movieArray[index]
        return temp
    }
}




