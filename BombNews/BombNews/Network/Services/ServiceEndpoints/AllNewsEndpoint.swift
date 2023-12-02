//
//  AllNewsEndpoint.swift
//  BombNews
//
//  Created by Barış Şaraldı on 30.11.2023.
//

import Foundation

// MARK: - AllNewsEndpoint
struct AllNewsEndpoint: Endpoint {
    
     private enum Constant {
         static let countryName: String = "country"
    }
    
    var path: Path {
        return .defaultPath
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: Constant.countryName, value: Locale.current.region?.identifier.lowercased())]
    }
}
