//
//  NewsListViewStates.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import Foundation

// MARK: - NewsListViewStates
enum NewsListViewStates: ViewStateProtocol {
    case ready
    case loading
    case finished
    case error
    case empty
}
