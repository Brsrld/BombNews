//
//  AllNewsEndpoint.swift
//  BombNews
//
//  Created by Barış Şaraldı on 30.11.2023.
//

import Foundation

// MARK: - AllNewsEndpoint
struct AllNewsEndpoint: Endpoint {
    var path: Path {
        return .defaultPath
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "country", value: Locale.current.region?.identifier.lowercased())]
    }
}
