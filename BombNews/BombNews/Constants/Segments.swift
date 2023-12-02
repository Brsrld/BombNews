//
//  Segments.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import Foundation

// MARK: - Segments
enum Segments: CaseIterable {
    case deepSearch
    case localSearch
    
    var title: String {
        switch self {
        case .deepSearch:
            return "Deep Search"
        case .localSearch:
            return "Local Search"
        }
    }
}
