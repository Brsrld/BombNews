//
//  SegmentsTest.swift
//  BombNewsTests
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import Foundation
import XCTest
@testable import BombNews

class SegmentsTests: XCTestCase {
    
    func testSegmentTitles() {
        XCTAssertEqual(Segments.deepSearch.title, "Deep Search", "Incorrect title for Deep Search")
        XCTAssertEqual(Segments.localSearch.title, "Local Search", "Incorrect title for Local Search")
    }
    
    func testAllCases() {
        let allCases = Segments.allCases
        XCTAssertEqual(allCases.count, 2, "Number of cases should be 2")
        XCTAssertTrue(allCases.contains(.deepSearch), "Deep Search case should be present")
        XCTAssertTrue(allCases.contains(.localSearch), "Local Search case should be present")
    }
}
