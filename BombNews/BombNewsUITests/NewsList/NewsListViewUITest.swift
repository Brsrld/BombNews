//
//  NewsListViewUITest.swift
//  BombNewsUITests
//
//  Created by Barış Şaraldı on 3.12.2023.
//

import XCTest

final class NewsListViewUITest: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-networking-success":"1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func testNavBar() throws {
        let title = app.staticTexts["News List"]
        let navBar = app.navigationBars.element
        let loading = app.staticTexts["Loading"]
        
        XCTAssert(navBar.exists)
        XCTAssert(title.waitForExistence(timeout: 0.5))
        XCTAssert(loading.exists)
    }
    
    func testsearchBar() throws {
        let searchBar = app.searchFields.element
        XCTAssertEqual(searchBar.placeholderValue, "Find or search news")
    }
    
    func testPicker() throws {
        let segmentedControl = app.segmentedControls["search"]
        XCTAssert(segmentedControl.exists)
        XCTAssert(segmentedControl.buttons["Local Search"].isSelected)
        
        segmentedControl.buttons["Deep Search"].tap()
        XCTAssert(segmentedControl.buttons["Deep Search"].isSelected)
    }
    
    func testNavigation() throws {
        let detail = app.otherElements.buttons["detail"].firstMatch
        XCTAssert(detail.exists)
    }
}
