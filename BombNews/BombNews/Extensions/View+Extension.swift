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
    //desc yaz
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
    
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}
