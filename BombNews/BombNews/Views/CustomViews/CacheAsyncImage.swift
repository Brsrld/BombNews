//
//  CacheAsyncImage.swift
//  BombNews
//
//  Created by Barış Şaraldı on 1.12.2023.
//

import SwiftUI

// MARK: - CacheAsyncImage
struct CacheAsyncImage<Content>: View where Content: View {
    
    private let urlString: String
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(urlString: String,
         scale: CGFloat = 1.0,
         transaction: Transaction = Transaction(),
         @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.urlString = urlString
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        if let url = URL(string: urlString) {
            if let cached = ImageCache[url] {
                content(.success(cached))
            } else {
                AsyncImage(url: url,
                           scale: scale,
                           transaction: transaction) { phase in
                    cacheAndRender(phase: phase, url: url)
                }
            }
        }
    }
    
    private func cacheAndRender(phase: AsyncImagePhase, url: URL) -> some View {
        if case .success(let image) = phase {
            ImageCache[url] = image.resizable()
        }
        return content(phase)
    }
}

// MARK: - ImageCache
fileprivate final class ImageCache {
    static private var cache: [URL: Image] = [:]
    
    static subscript(url: URL) -> Image? {
        get {
            ImageCache.cache[url]
        }
        set {
            ImageCache.cache[url] = newValue
        }
    }
}
