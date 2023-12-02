//
//  MockHttpClient.swift
//  BombNewsTests
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import Foundation
@testable import BombNews

final class MockHttpClient: NewsListServiceable, Mockable {
    let filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    func fetchAllNews() async -> Result<BombNews.NewsResponse, BombNews.RequestError> {
        return await loadJson(filename: filename,
                              extensionType: .json,
                              responseModel: BombNews.NewsResponse.self)
    }
    
    func fetchSearchedNews(searchText query: String) async -> Result<BombNews.NewsResponse, BombNews.RequestError> {
        return await loadJson(filename: filename,
                              extensionType: .json,
                              responseModel: BombNews.NewsResponse.self)
    }
}
