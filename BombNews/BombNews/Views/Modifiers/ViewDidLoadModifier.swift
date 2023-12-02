//
//  ViewDidLoadModifier.swift
//  BombNews
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import SwiftUI

// MARK: - ViewDidLoadModifier
struct ViewDidLoadModifier: ViewModifier {
    
    @State private var didLoad = false
    private let action: (() -> Void)?
    
    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }
}
