//
//  HttpClientTest.swift
//  BombNewsTests
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import Foundation
@testable import BombNews
import XCTest

class HttpClientTest: XCTestCase {
    var urlSession: URLSession!
    var endpoint: Endpoint!
    var service: HTTPClientProtocol!
    
    let mockString =
    """
    {
        "status": "ok",
        "totalResults": 11085,
        "articles": [
            {
                "source": {
                    "id": null,
                    "name": "Ambcrypto.com"
                },
                "author": "Ishika Kumari",
                "title": "TinyTesla (TINT): The revolutionary token electrifying the crypto world",
                "description": "Are you tired of the same old cryptocurrencies with no real-world use cases? Do you want to invest in a token that has the potential to disrupt entire industries? Look no further than TinyTesla (TINT), the revolutionary new token that’s taking the crypto worl…",
                "url": "https://ambcrypto.com/tinytesla-tint-the-revolutionary-token-electrifying-the-crypto-world-2/",
                "urlToImage": "https://statics.ambcrypto.com/wp-content/uploads/2023/04/Screenshot-2023-04-03-at-5.01.13-PM-1000x600.png",
                "publishedAt": "2023-04-03T11:45:00Z",
                "content": "Are you tired of the same old cryptocurrencies with no real-world use cases? Do you want to invest in a token that has the potential to disrupt entire industries? Look no further than TinyTesla (TINT… [+2935 chars]"
            }
        ]
    }
    """
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        urlSession = URLSession(configuration: config)
        endpoint = AllNewsEndpoint()
        service = HttpClient(urlSession: urlSession)
    }
    
    override func tearDown() {
        urlSession = nil
        endpoint = nil
        super.tearDown()
    }
    
    func test_Get_Data_Success() async throws {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host.url
        urlComponents.path = endpoint.path.path
        urlComponents.queryItems = endpoint.queryItems
        
        let response = HTTPURLResponse(url: urlComponents.url!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        Task {
            let result = await service.sendRequest(endpoint: endpoint,
                                           responseModel: NewsResponse.self)
            switch result {
            case .success(let success):
                XCTAssertEqual(success.articles?.first?.title,"TinyTesla (TINT): The revolutionary token electrifying the crypto world")
                XCTAssertEqual(success.articles?.count, 1)
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        await fulfillment(of: [expectation], timeout: 2)
    }
    
    func test_News_BadResponse() {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host.url
        urlComponents.path = endpoint.path.path
        urlComponents.queryItems = endpoint.queryItems
        
        let response = HTTPURLResponse(url: urlComponents.url!,
                                       statusCode: 400,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        Task {
            let result = await service.sendRequest(endpoint: endpoint,
                                           responseModel: NewsResponse.self)
            switch result {
            case .success(_):
                XCTAssertThrowsError("Fatal Error")
            case .failure(let failure):
                XCTAssertEqual(RequestError.unexpectedStatusCode, failure)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func test_News_EncodingError() {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host.url
        urlComponents.path = endpoint.path.path
        urlComponents.queryItems = endpoint.queryItems
        
        let response = HTTPURLResponse(url: urlComponents.url!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        Task {
            let result = await service.sendRequest(endpoint: endpoint,
                                           responseModel: [NewsResponse].self)
            switch result {
            case .success(_):
                XCTAssertThrowsError("Fatal Error")
            case .failure(let failure):
                XCTAssertEqual(RequestError.decode, failure)
                expectation.fulfill()
            }
        }
    }
    
    func test_News_InvalidURL() {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = "endpoint.host.url"
        urlComponents.path = " endpoint.path.path"
        urlComponents.queryItems = endpoint.queryItems
        
        let expectation = XCTestExpectation(description: "url error")
        
        if let url = urlComponents.url {
            let response = HTTPURLResponse(url: url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
        } else {
            XCTAssertEqual(urlComponents.url, nil)
            expectation.fulfill()
        }
    }
}
