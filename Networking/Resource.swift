//
//  Resource.swift
//  
//
//  Created by Pradeep Dahiya on 25.10.17.
//  Copyright © 2017 Pradeep Dahiya. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

struct Resource<A> {
    let url: String
    let method: HTTPMethod
    let parse: (Data) -> A?
}
