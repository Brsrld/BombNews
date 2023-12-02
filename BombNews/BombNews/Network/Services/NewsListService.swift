//
//  NewsListServiceable.swift
//  BombNews
//
//  Created by Barış Şaraldı on 30.11.2023.
//

import Foundation

// MARK: - HomeServiceable
protocol NewsListServiceable {
    func fetchAllNews() async -> Result<NewsResponse, RequestError>
    func fetchSearchedNews(searchText: String) async -> Result<NewsResponse, RequestError>
}

// MARK: - HomeService
struct NewsListService: NewsListServiceable {
    private let service: HTTPClientProtocol
    
    init(service: HTTPClientProtocol) {
        self.service = service
    }
    func fetchSearchedNews(searchText: String) async -> Result<NewsResponse, RequestError> {
        return await service.sendRequest(endpoint: SearchNewsEndpoint(searchText: searchText), responseModel: NewsResponse.self)
    }
    
    func fetchAllNews() async -> Result<NewsResponse, RequestError> {
        return await service.sendRequest(endpoint: AllNewsEndpoint(), responseModel: NewsResponse.self)
    }
}
