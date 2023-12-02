//
//  SearchNewsEndpoint.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import Foundation

// MARK: - SearchNewsEndpoint
struct SearchNewsEndpoint: Endpoint {
    
    private enum Constant {
        static let querySymbol: String = "q"
   }
    
    var searchText: String
    
    var path: Path {
        return .defaultPath
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: Constant.querySymbol, value: searchText)]
    }
}
