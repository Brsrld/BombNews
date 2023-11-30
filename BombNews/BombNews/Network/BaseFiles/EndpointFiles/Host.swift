//
//  Host.swift
//  BombNews
//
//  Created by Barış Şaraldı on 30.11.2023.
//

import Foundation

// MARK: - Host
 enum Host {
    case defaultHost
    
    var url: String {
        switch self {
        case .defaultHost:
            return "newsapi.org"
        }
    }
}
