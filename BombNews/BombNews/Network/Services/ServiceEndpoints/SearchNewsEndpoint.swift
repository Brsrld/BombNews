//
//  SearchNewsEndpoint.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import Foundation

// MARK: - SearchNewsEndpoint
struct SearchNewsEndpoint: Endpoint {
    var searchText: String
    
    var path: Path {
        return .defaultPath
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "q", value: searchText)]
    }
}
