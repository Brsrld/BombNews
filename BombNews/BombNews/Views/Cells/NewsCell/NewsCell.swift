//
//  NewsCells.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import SwiftUI

// MARK: - NewsCell
struct NewsCell: View {
    
    private enum Constant {
        static let bodyCornerRadius: CGFloat = 8
        static let bodyShadowRadius: CGFloat = 5
        static let bodySpacing: CGFloat = 12
        static let zeroValue: CGFloat = 0
        static let imageHeight: CGFloat = UIScreen.screenHeight / 8
        static let emptyImageSystemImage: String  = "exclamationmark.circle"
    }
    
    private let item: NewsCellUIModel
    
    init(item: NewsCellUIModel) {
        self.item = item
    }
    
    var body: some View {
        VStack(spacing: Constant.bodySpacing) {
            movieImage()
            textViews()
        }
        .background(Color.cellColor)
        .cornerRadius(Constant.bodyCornerRadius)
        .padding(.horizontal)
        .shadow(radius: Constant.bodyShadowRadius)
    }
    
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
    
    private func label(text: String, 
                       color: Color,
                       footNote: Font) -> some View {
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
        VStack {
            CacheAsyncImage(urlString: item.imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                case .failure(_):
                    Image(systemName: Constant.emptyImageSystemImage)
                @unknown default:
                    fatalError()
                }
            }
        }
        .frame(height: item.imageUrl.isEmpty ?
               Constant.zeroValue : Constant.imageHeight)
    }
}

#Preview {
    NewsCell(item: NewsCellUIModel(imageUrl: "https://www.reuters.com/resizer/-9uubUtwVpA0QW9zWGHoxPLwhBk=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/PW5QFB7KPVL4HLO3EMDE3LUJFM.jpg",
                                   owner: "Reuters",
                                   title: "French government rejects union demand to rethink pension bill - Reuters",
                                   date: "2023-03-28T12:20:00Z".calculateTime()))
}
