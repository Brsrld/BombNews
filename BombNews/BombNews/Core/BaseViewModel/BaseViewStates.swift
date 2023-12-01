//
//  BaseViewStates.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import Foundation

protocol ViewStateProtocol: Equatable {
    static var ready: Self { get }
}

protocol ViewStatable: Equatable {
    associatedtype ViewState: ViewStatable = DefaultViewState
}

enum DefaultViewState: ViewStateProtocol {
    case ready
}
