//
//  MockHttpClient.swift
//  BombNewsTests
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import Foundation
@testable import BombNews

final class MockHttpClient: NewsListServiceable {
    
    let filename: String
    private let service: Mockable
    
    init(filename: String, service: Mockable) {
        self.filename = filename
        self.service = service
    }
    
    func fetchAllNews() async -> Result<BombNews.NewsResponse, BombNews.RequestError> {
        return await service.loadJson(filename: filename,
                              extensionType: .json,
                              responseModel: BombNews.NewsResponse.self)
    }
    
    func fetchSearchedNews(searchText query: String) async -> Result<BombNews.NewsResponse, BombNews.RequestError> {
        return await service.loadJson(filename: filename,
                              extensionType: .json,
                              responseModel: BombNews.NewsResponse.self)
    }
}
