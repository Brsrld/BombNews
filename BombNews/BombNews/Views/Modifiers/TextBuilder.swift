//
//  TextBuilder.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import SwiftUI

// MARK: - TextBuilder
///TextBuilder a builder to escape duplicate text features.
struct TextBuilder: ViewModifier {

    let textColor: Color
    let textFont: Font
    let alingment: TextAlignment
    
    init(textColor: Color = Color.black,
         textFont:Font,
         alingment:TextAlignment) {
        self.textColor = textColor
        self.textFont = textFont
        self.alingment = alingment
    }
    
    func body(content: Content) -> some View{
        content
            .font(textFont)
            .foregroundColor(textColor)
            .multilineTextAlignment(alingment)
            .fixedSize(horizontal: false, vertical: true)
    }
}
