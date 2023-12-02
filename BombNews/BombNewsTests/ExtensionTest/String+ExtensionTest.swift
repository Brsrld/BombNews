//
//  String+ExtensionTest.swift
//  BombNewsTests
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import Foundation
import XCTest
@testable import BombNews

class StringExtensionsTests: XCTestCase {
    
    func testCalculateTime() {
        let dateString = "2023-01-01T12:00:00Z"
        let calculatedTime = dateString.calculateTime()
        
        XCTAssertNotNil(calculatedTime, "Calculated time should not be nil")
        XCTAssertFalse(calculatedTime.isEmpty, "Calculated time should not be empty")
        print("Calculated Time: \(calculatedTime)")
    }
    
    func testIsValid() {
        let validString = " valid"
        let invalidString = "invalid"
        
        XCTAssertTrue(validString.isValid(), "The string should be valid")
        XCTAssertFalse(invalidString.isValid(), "The string should be invalid")
    }
}
