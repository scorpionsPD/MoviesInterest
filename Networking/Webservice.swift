//
//  Webservice.swift
//  
//
//  Created by Pradeep Dahiya on 25.10.17.
//  Copyright © 2017 Pradeep Dahiya. All rights reserved.
//

import UIKit
import SystemConfiguration

enum NetworkError: Error {
    case parseUrl
    case parseJson
    case parseData
    case emptyResource
}

enum Webservice {
    static var numberOfRequests = 0 {
        didSet {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible =
                    numberOfRequests > 0
            }
        }
    }
    
    @discardableResult
    static func load<A>(resource: Resource<A>?, completion: @escaping (Result<A, Error>) -> Void) -> URLSessionTask? {
        guard let resource = resource else {
            completion(.failure(NetworkError.emptyResource))
            return nil
        }
        guard let url = URL(string: resource.url) else {
            completion(.failure(NetworkError.parseUrl))
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = resource.method.rawValue

        numberOfRequests += 1

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            numberOfRequests -= 1

            guard error == nil, let data = data else {
                completion(.failure(error!))
                return
            }
            guard let result = resource.parse(data) else {
                completion(.failure(NetworkError.parseData))
                return
            }
            completion(.success(result))
        }

        task.resume()
        return task
    }
}

public class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        if flags.isEmpty {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}

