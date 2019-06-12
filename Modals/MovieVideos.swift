//
//  MovieVideos.swift
//  ApiTest
//
//  Created by Pradeep Dahiya on 22/03/19.
//  Copyright © 2019 Pradeep Dahiya. All rights reserved.
//

import Foundation

struct MovieVideos: Codable {
    let id: Int
    let results: [Result]
    
    struct Result: Codable {
        let id, iso639_1, iso3166_1, key: String
        let name, site: String
        let size: Int
        let type: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case iso639_1 = "iso_639_1"
            case iso3166_1 = "iso_3166_1"
            case key, name, site, size, type
        }
    }
}
// MARK: Convenience initializers

extension MovieVideos {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(MovieVideos.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    init?(fromURL url: String) {
        guard let url = URL(string: url) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
