//
//  NewsResponse.swift
//  BombNews
//
//  Created by Barış Şaraldı on 30.11.2023.
//

import Foundation

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
}

// MARK: - Article
struct Article: Codable, Hashable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.title == rhs.title
    }
    
    let source: Source?
    let author: String?
    let title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable, Hashable {
    let id: String?
    let name: String?
}
