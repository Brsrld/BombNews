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
struct NewsListService: HTTPClient, NewsListServiceable {
    func fetchSearchedNews(searchText: String) async -> Result<NewsResponse, RequestError> {
        return await sendRequest(endpoint: SearchNewsEndpoint(searchText: searchText), responseModel: NewsResponse.self)
    }
    
    func fetchAllNews() async -> Result<NewsResponse, RequestError> {
        return await sendRequest(endpoint: AllNewsEndpoint(), responseModel: NewsResponse.self)
    }
}
