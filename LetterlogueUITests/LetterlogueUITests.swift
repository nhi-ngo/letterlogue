//
//  LetterlogueUITests.swift
//  LetterlogueUITests
//
//  Created by Nhi Ngo on 6/13/25.
//

import XCTest

final class LetterlogueUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    @MainActor
    func testAddLetter() throws {
        let addButton = app.buttons["addLetterButton"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 2), "Add button should exist")
        addButton.tap()
        
        let titleField = app.textFields["titleField"]
        XCTAssertTrue(titleField.exists, "Title should exist")
        titleField.tap()
        titleField.typeText("This is the title of the test letter")
        
        let contentEditor = app.textViews["contentEditor"]
        XCTAssertTrue(contentEditor.exists, "Content should exist")
        contentEditor.tap()
        contentEditor.typeText("This is the content of the test letter")
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        let newLetterTitle = app.staticTexts["This is the title of the test letter"]
        XCTAssertTrue(newLetterTitle.waitForExistence(timeout: 5))
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
