//
//  Endpoint.swift
//  BombNews
//
//  Created by Barış Şaraldı on 30.11.2023.
//

import Foundation

// MARK: - Endpoint
protocol Endpoint {
    var scheme: String { get }
    var host: Host { get }
    var path: Path { get }
    var method: RequestMethod { get }
    var header: Header { get }
    var body: Body { get }
    var queryItems: [URLQueryItem]? { get }
}

// MARK: - Endpoint Extension
extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: Host {
        return .defaultHost
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var body: Body {
        return .nilBody
    }
    
    var queryItems: [URLQueryItem]?  {
        return nil
    }
    
    
    var header: Header {
        return .defaultHeader
    }
}
