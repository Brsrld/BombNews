//
//  View+Extension.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import Foundation
import SwiftUI

// MARK: - View
extension View {
    
    ///OnLoad a function which work one time every render time.
    ///We can think like viewdidload function in the UIKit.
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
    
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}
