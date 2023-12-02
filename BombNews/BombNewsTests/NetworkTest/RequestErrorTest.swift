//
//  RequestErrorTest.swift
//  BombNewsTests
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import XCTest
@testable import BombNews

class SearchNewsEndpointTests: XCTestCase {
    
    func testSearchNewsEndpoint() {
        let searchText = "breaking news"
        let endpoint = SearchNewsEndpoint(searchText: searchText)
        
        XCTAssertEqual(endpoint.path, .defaultPath, "Path should be the default path")
        
        XCTAssertEqual(endpoint.queryItems?.count, 1, "There should be one query item")
        XCTAssertEqual(endpoint.queryItems?.first?.name, "q", "Query item name should be 'q'")
        XCTAssertEqual(endpoint.queryItems?.first?.value, searchText, "Query item value should be the search text")
    }
}
