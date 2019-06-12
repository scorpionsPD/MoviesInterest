//
//  DetailDataSource.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 25/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import UIKit

enum MovieModelItemType: Int {
    case nameAndPicture = 0
    case videos
    case casting
}

struct SingleCredit {
    let charecterName: String
    let realName: String
    let image: String
}

protocol MovieViewModelItem {
    var type: MovieModelItemType { get }
    var rowCount: Int { get }
}

class DetailDataSource: NSObject {
    
    var items = [MovieViewModelItem]()
    
    init(data:CompleteMovieDetailModal?) {
        
        let nameAndPictureItem = MovieModelNamePictureItem(name: (data?.movieDetail.title)!, pictureUrl: (data?.movieDetail.posterPath ?? ""), releaseDate: "", genre: (data?.movieDetail.genreString())!, overView: (data?.movieDetail.overview)!)
        items.append(nameAndPictureItem)
        
        var videosArray = Array<MovieVideo>()
        
        if let unwrapedVideos = data?.movieVideos.results {
            for video in unwrapedVideos{
                let newVideo = MovieVideo(name: video.name, key: video.key)
                videosArray.append(newVideo)
            }
            let movieVideoContent = MovieVideoContent(videosArray: videosArray)
            self.items.append(movieVideoContent)
        }
        var creditArray = Array<SingleCredit>()
        if let unrappedCredit = data?.credits.cast {
            for cred in unrappedCredit{
                let newCredit = SingleCredit(charecterName: cred.character, realName: cred.name, image: cred.profilePath ?? "")
                creditArray.append(newCredit)
            }
        }
        let movieCreditContent = MovieCastings(castingArray: creditArray)
        self.items.append(movieCreditContent)
    }
}

class MovieViewModal: NSObject {
    var items = [MovieViewModelItem]()
    
}
class MovieModelNamePictureItem: MovieViewModelItem {
    var type: MovieModelItemType {
        return .nameAndPicture
    }
    var rowCount: Int {
        return 1
    }
    
    var name: String
    var genre: String
    var releaseDate: String
    var pictureUrl: String?
    var overView: String
    
    init(name: String, pictureUrl: String,releaseDate: String,genre: String,overView: String) {
        self.name = name
        self.pictureUrl = pictureUrl
        self.releaseDate = releaseDate
        self.genre = genre
        self.overView = overView
    }
}

class MovieVideoContent: MovieViewModelItem {
    var type: MovieModelItemType{
        return .videos
    }
    var rowCount: Int{
        return 1
    }
    var videosArray: [MovieVideo]

    init(videosArray: [MovieVideo]) {
        self.videosArray = videosArray
    }
}

class MovieCastings: MovieViewModelItem {
    var type: MovieModelItemType{
        return .casting
    }
    
    var rowCount: Int{
        return 1
    }
    
    var castingArray: [SingleCredit]
    
    init(castingArray: [SingleCredit]) {
        self.castingArray = castingArray
    }
}
extension DetailDataSource: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.section]
        switch item.type {
        case .nameAndPicture:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieHeaderCell.self)) as! MovieHeaderCell
            cell.backgroundColor = UIColor.black
            cell.item = item
            return cell
        case .videos:
            if let item = item as? MovieVideoContent, let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieVideosTableViewCell.self)) as? MovieVideosTableViewCell{
            cell.item = item.videosArray
            cell.backgroundColor = UIColor.clear
            return cell
            }
        case .casting:
            if let item = item as? MovieCastings, let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CastCrewTableViewCell.self)) as? CastCrewTableViewCell{
                cell.item = item.castingArray
                cell.backgroundColor = UIColor.black
                return cell
            }
        }
    return UITableViewCell()
    }
}
