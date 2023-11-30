//
//  Path.swift
//  BombNews
//
//  Created by Barış Şaraldı on 30.11.2023.
//

import Foundation

// MARK: - Path
enum Path: String {
    case defaultPath
    
    var path: String {
        switch self {
        case .defaultPath:
            return "/v2/top-headlines"
        }
    }
}
