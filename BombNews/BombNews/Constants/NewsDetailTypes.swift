//
//  NewsDetailTypes.swift.swift
//  BombNews
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import Foundation

// MARK: - NewsDetailTypes
enum NewsDetailTypes: CaseIterable {
    case reader
    case web
    
    var title: String {
        switch self {
        case .reader:
            return "Reader"
        case .web:
            return "Web"
        }
    }
}
