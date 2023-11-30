//
//  HomeServiceable.swift
//  BombNews
//
//  Created by Barış Şaraldı on 30.11.2023.
//

import Foundation

// MARK: - HomeServiceable
protocol HomeServiceable {
    func fetchAllNews() async -> Result<NewsResponse, RequestError>
}

// MARK: - HomeService
struct HomeService: HTTPClient, HomeServiceable {
    func fetchAllNews() async -> Result<NewsResponse, RequestError> {
        return await sendRequest(endpoint: AllNewsEndpoint(), responseModel: NewsResponse.self)
    }
}
