//
//  GenreTypes.swift
//  SwipeDemo
//
//  Created by Pradeep Dahiya on 24/05/2019.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import Foundation

public enum getGenreString: Int {
    case Action = 28,
    Adventure = 12,
    Animation = 16,
    Comedy = 35,
    Crime = 80,
    Documentary = 99,
    Drama = 18,
    Family = 10751,
    Fantasy = 14,
    History = 36,
    Horror = 27,
    Music = 10402,
    Mystery = 9648,
    Romance = 10749,
    ScienceFiction = 878,
    TVMovie = 10770,
    Thriller = 53,
    War = 10752,
    Western = 37
    
    public init(rawValue:Int){
        switch rawValue {
            
        case getGenreString.Action.rawValue:
            self = getGenreString.Action
            
        case getGenreString.Adventure.rawValue:
            self = getGenreString.Adventure
            
        case getGenreString.Animation.rawValue:
            self = getGenreString.Animation
            
        case getGenreString.Comedy.rawValue:
            self = getGenreString.Comedy
            
        case getGenreString.Crime.rawValue:
            self = getGenreString.Crime
            
        case getGenreString.Documentary.rawValue:
            self = getGenreString.Documentary
            
        case getGenreString.Drama.rawValue:
            self = getGenreString.Drama
            
        case getGenreString.Family.rawValue:
            self = getGenreString.Family
            
        case getGenreString.Fantasy.rawValue:
            self = getGenreString.Fantasy
            
        case getGenreString.History.rawValue:
            self = getGenreString.History
            
        case getGenreString.Horror.rawValue:
            self = getGenreString.Horror
            
        case getGenreString.Music.rawValue:
            self = getGenreString.Music
            
        case getGenreString.Mystery.rawValue:
            self = getGenreString.Mystery
            
        case getGenreString.Romance.rawValue:
            self = getGenreString.Romance
            
        case getGenreString.ScienceFiction.rawValue:
            self = getGenreString.ScienceFiction
            
        case getGenreString.TVMovie.rawValue:
            self = getGenreString.TVMovie
            
        case getGenreString.Thriller.rawValue:
            self = getGenreString.Thriller
            
        case getGenreString.Western.rawValue:
            self = getGenreString.Western
            
        case getGenreString.War.rawValue:
            self = getGenreString.War
        
        default:
            self = getGenreString.Action
        }
    }
}

