//
//  LazyView.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import SwiftUI

struct LazyView<Content: View>: View {
    
    private let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
