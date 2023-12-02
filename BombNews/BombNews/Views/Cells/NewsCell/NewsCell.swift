//
//  NewsCells.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import SwiftUI

// MARK: - NewsCell
struct NewsCell: View {
    
    let item: NewsCellItem
    @State var isEmpty = false
    
    init(item: NewsCellItem) {
        self.item = item
    }
    
    var body: some View {
        VStack(spacing: 12) {
            movieImage()
            textViews()
        }
        .background(Color.cellColor)
        .cornerRadius(8)
        .padding(.horizontal)
        .shadow(radius: 5)
    }
    
    @ViewBuilder
    private func textViews() -> some View {
        HStack {
            VStack {
                label(text: item.owner, 
                      color: .gray,
                      footNote: .footnote)
                label(text: item.title,
                      color: .textColor,
                      footNote: .subheadline)
                label(text: item.date, 
                      color: .gray, 
                      footNote: .footnote)
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func label(text: String, color: Color, footNote: Font) -> some View {
        HStack {
            Text(text)
                .modifier(TextBuilder(textColor: color,
                                      textFont: footNote,
                                      alingment: .leading))
                .padding(.leading)
                .padding(.bottom)
            Spacer()
        }
    }
    
    @ViewBuilder
    private func movieImage() -> some View {
        if let url = URL(string: item.imageUrl) {
            VStack {
                CacheAsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                    case .failure(_):
                       EmptyView()
                            .task {
                                isEmpty.toggle()
                            }
                    @unknown default:
                        fatalError()
                    }
                }
            }
            .frame(height: isEmpty ? 0 : UIScreen.screenHeight / 8)
        }
    }
}

#Preview {
    NewsCell(item: NewsCellItem(imageUrl: "https://www.reuters.com/resizer/-9uubUtwVpA0QW9zWGHoxPLwhBk=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/PW5QFB7KPVL4HLO3EMDE3LUJFM.jpg",
                                owner: "Reuters",
                                title: "French government rejects union demand to rethink pension bill - Reuters",
                                date: "2023-03-28T12:20:00Z".calculateTime()))
}
