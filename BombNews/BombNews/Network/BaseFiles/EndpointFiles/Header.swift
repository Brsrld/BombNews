//
//  Header.swift
//  BombNews
//
//  Created by Barış Şaraldı on 30.11.2023.
//

import Foundation

// MARK: - Header
enum Header {
    case defaultHeader
    
    var header: [String : String]? {
        switch self {
        case .defaultHeader:
            return [
                "Authorization": "Bearer bb69b1ef681a4120ad0bde1a1ff38530",
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
    }
}
