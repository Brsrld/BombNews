//
//  NewsListViewModelTest.swift
//  BombNewsTests
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import XCTest
import Combine
@testable import BombNews

class NewsListViewModelTest: XCTestCase {
    private var viewModel: NewsListViewModel!
    private var cancellable: AnyCancellable?
    private var filename = "NewsResponse"
    private let isloadingExpectation = XCTestExpectation(description: "isLoading true")
    
    override func setUp() {
        super.setUp()
        
        viewModel = NewsListViewModel()
        viewModel.service = MockHttpClient(filename: filename)
        
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func test_ready_State() {
       let expectation = expectValue(of: viewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "is state ready",
                                     equals: [{ $0 == .ready}])
       wait(for: [expectation.expectation], timeout: 1)
   }
    
    func test_finished_State() {
       let expectation = expectValue(of: viewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "is state finished",
                                     equals: [{ $0 == .finished}])
        viewModel.serviceInitialize()
       wait(for: [expectation.expectation], timeout: 1)
   }
    
    func test_loading_State() {
       let expectation = expectValue(of: viewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "is state loading",
                                     equals: [{ $0 == .loading}])
        viewModel.serviceInitialize()
       wait(for: [expectation.expectation], timeout: 1)
   }
    
    func test_error_State() {
       filename = "error"
       setUp()
       let expectation = expectValue(of: viewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "is state error",
                                     equals: [{ $0 == .error}])
        viewModel.serviceInitialize()
       wait(for: [expectation.expectation], timeout: 1)
   }
    
    func test_ShowingAlert() {
       filename = "error"
       setUp()
        viewModel.serviceInitialize()
       
       cancellable = viewModel.objectWillChange.eraseToAnyPublisher().sink { _ in
           XCTAssertEqual(self.viewModel.showAlert, true)
           self.isloadingExpectation.fulfill()
       }
       wait(for: [isloadingExpectation], timeout: 1)
   }
    
    func test_empty_State() {
       let expectation = expectValue(of: viewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "is state empty",
                                     equals: [{ $0 == .empty}])
        viewModel.search(isOnchange: false)
       wait(for: [expectation.expectation], timeout: 1)
   }
    
    func test_localSearch_Success() {
        viewModel.searchQuery = "././././././."
        viewModel.segmentValue = .localSearch
        viewModel.serviceInitialize()
        
       let expectation = expectValue(of: viewModel.$states.eraseToAnyPublisher(),
                                     expectationDescription: "search success",
                                     equals: [{ $0 == .empty}])
        viewModel.search(isOnchange: false)
       wait(for: [expectation.expectation], timeout: 1)
   }
    
    func test_deepSearch_Success() {
        viewModel.searchQuery = "T"
        viewModel.segmentValue = .deepSearch
       let expectation = expectValue(of: viewModel.$filteredNews.eraseToAnyPublisher(),
                                     expectationDescription: "search success",
                                     equals: [{ $0.count == 1}])
        viewModel.search(isOnchange: false)
       wait(for: [expectation.expectation], timeout: 1)
   }
    
    func test_news_Success() {
       let expectation = expectValue(of: viewModel.$filteredNews.eraseToAnyPublisher(),
                                     expectationDescription: "Fetched News",
                                     equals: [{ $0.count == 1}])
        viewModel.serviceInitialize()
       wait(for: [expectation.expectation], timeout: 1)
   }
}
