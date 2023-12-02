//
//  NewsDetailTypes.swift
//  BombNewsTests
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import Foundation
import XCTest
@testable import BombNews

class NewsDetailTypesTests: XCTestCase {
    
    func testDetailTypeTitles() {
        XCTAssertEqual(NewsDetailTypes.reader.title, "Reader", "Incorrect title for Reader")
        XCTAssertEqual(NewsDetailTypes.web.title, "Web", "Incorrect title for Web")
    }
    
    func testAllCases() {
        let allCases = NewsDetailTypes.allCases
        XCTAssertEqual(allCases.count, 2, "Number of cases should be 2")
        XCTAssertTrue(allCases.contains(.reader), "Reader case should be present")
        XCTAssertTrue(allCases.contains(.web), "Web case should be present")
    }
}
