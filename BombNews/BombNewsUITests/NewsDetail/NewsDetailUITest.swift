//
//  NewsDetailUITest.swift
//  BombNewsUITests
//
//  Created by Barış Şaraldı on 3.12.2023.
//

import XCTest

final class NewsDetailUITest: XCTestCase {

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
    
    func testNavigation() throws {
        let detail = app.otherElements.buttons["detail"].firstMatch
        detail.tap()
    }
    
    func testNavBar() throws {
        try testNavigation()
        let navBar = app.navigationBars.element
        
        XCTAssert(navBar.exists)
    }
    
    func testImage() throws {
        try testNavigation()
        let image = app.images.element
        XCTAssert(image.exists)
    }
    
    func testPicker() throws {
        try testNavigation()
        let segmentedControl = app.segmentedControls["type"]
        XCTAssert(segmentedControl.exists)
        XCTAssert(segmentedControl.buttons["Reader"].isSelected)
        
        segmentedControl.buttons["Web"].tap()
        XCTAssert(segmentedControl.buttons["Web"].isSelected)
    }
    
    func testWebview() throws {
        try testNavigation()
        let segmentedControl = app.segmentedControls["type"]
        segmentedControl.buttons["Web"].tap()
        let webview = app.webViews.element
        XCTAssert(webview.exists)
    }
}
