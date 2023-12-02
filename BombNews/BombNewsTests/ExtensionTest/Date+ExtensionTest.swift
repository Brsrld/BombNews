//
//  Date+ExtensionTest.swift
//  BombNewsTests
//
//  Created by Barış Şaraldı on 2.12.2023.
//

import Foundation
import XCTest
@testable import BombNews

class DateExtensionsTests: XCTestCase {
    
    func testHoursDifference() {
        let startDate = Date(timeIntervalSinceReferenceDate: 0)  
        let endDate = startDate.addingTimeInterval(3600)
        
        let hoursDifference = endDate.hours(from: startDate)
        XCTAssertEqual(hoursDifference, 1, "Incorrect hours difference, expected 1 hour")
    }
    
    func testDaysDifference() {
        let startDate = Date(timeIntervalSinceReferenceDate: 0)
        let endDate = startDate.addingTimeInterval(86400)
        
        let daysDifference = endDate.days(from: startDate)
        XCTAssertEqual(daysDifference, 1, "Incorrect days difference, expected 1 day")
    }
}
