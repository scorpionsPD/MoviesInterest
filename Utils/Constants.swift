//
//  Config.swift
//  
//
//  Created by Pradeep Dahiya on 21.02.18.
//  Copyright © 2018 Pradeep Dahiya. All rights reserved.
//

import Foundation
import UIKit

let MAX_WIDTH = UIScreen.main.bounds.size.width
let MAX_HEIGHT = UIScreen.main.bounds.size.height

enum Constants {
    enum Backend {
        static let url = "https://api.themoviedb.org/3"
        static let shareMovieUrl = "https://www.themoviedb.org/movie/"
    }

    static let appStoreUrl = "https://itunes.apple.com/app/id1402748020"

    enum UserDefaults {
        static let usernameKey = "-username"
    }

    enum PosterSize {
        case small
        case original

        var address: String {
            let host = "https://image.tmdb.org/t/p"

            switch self {
            case .small:
                return "\(host)/w342"
            case .original:
                return "\(host)/original"
            }
        }
    }
}
