//
//  NewsDetailViewModelTest.swift
//  BombNewsTests
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import XCTest
import Combine
@testable import BombNews

class NewsDetailViewModelTest: XCTestCase {
    private var viewModel: NewsDetailViewModel!
    private let defaultExpectation = XCTestExpectation(description: "is default type")
    private let allTypesExpectation = XCTestExpectation(description: "all categories")
    private let newsDetailCheck = XCTestExpectation(description: "news detail check")
    
    override func setUp() {
        super.setUp()
        
        viewModel = NewsDetailViewModel(newsDetail: Article(source: nil,
                                                                      author: "Ishika Kumari",
                                                                      title: "TinyTesla (TINT): The revolutionary token electrifying the crypto world",
                                                                      description: "Are you tired of the same old cryptocurrencies with no real-world use cases? Do you want to invest in a token that has the potential to disrupt entire industries? Look no further than TinyTesla (TINT), the revolutionary new token that’s taking the crypto worl…",
                                                                      url: "https://ambcrypto.com/tinytesla-tint-the-revolutionary-token-electrifying-the-crypto-world-2/",
                                                                      urlToImage: "https://statics.ambcrypto.com/wp-content/uploads/2023/04/Screenshot-2023-04-03-at-5.01.13-PM-1000x600.png",
                                                                      publishedAt: "2023-04-03T11:45:00Z",
                                                                      content: "Are you tired of the same old cryptocurrencies with no real-world use cases? Do you want to invest in a token that has the potential to disrupt entire industries? Look no further than TinyTesla (TINT… [+2935 chars]"))
    }
    
    override func tearDown() {
        viewModel = nil
        
        super.tearDown()
    }
    
    func test_default_Type() {
        XCTAssertEqual(self.viewModel.newsType, .reader)
        self.defaultExpectation.fulfill()
    }
    
    func test_all_Types() {
        XCTAssertEqual(viewModel.newsTypeArray.last?.title,  "Web")
        self.allTypesExpectation.fulfill()
    }
    
    func test_states() {
        let expectation = expectValue(of: viewModel.$states.eraseToAnyPublisher(),
                                      expectationDescription: "states check",
                                      equals: [{ $0 == .ready}])
        viewModel.changeNewsType()
        wait(for: [expectation.expectation], timeout: 1)
    }
    
    func test_check_Content() {
        XCTAssertEqual(viewModel.newsDetail.title?.isEmpty,  false)
        self.newsDetailCheck.fulfill()
    }
}
