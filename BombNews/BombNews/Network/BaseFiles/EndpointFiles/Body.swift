//
//  Body.swift
//  BombNews
//
//  Created by Barış Şaraldı on 30.11.2023.
//

import Foundation

// MARK: - Path
enum Body {
    case nilBody
    
    var body: [String: Any]? {
        switch self {
        case .nilBody:
            return nil
        }
    }
}
