//
//  AutentiaScrumCardsUITests.swift
//  AutentiaScrumCardsUITests
//
//  Created by Anton Zuev on 30/01/2019.
//

import XCTest

class AutentiaScrumCardsUITests: XCTestCase {
    
    let app = XCUIApplication()
    var cerrarButton: XCUIElement!
    var menButton: XCUIElement!
    var collectionViewsQuery: XCUIElementQuery!
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        app.launch()
        cerrarButton = app.buttons["Cerrar"]
        menButton = app.navigationBars["AutentiaScrumCards.MainView"].buttons["Menú"]
        collectionViewsQuery = app.collectionViews

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFibonacciCards() {
        XCUIApplication().buttons["Fibonacci"].tap()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["100"]/*[[".cells.buttons[\"100\"]",".buttons[\"100\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.images["card_100"].exists)
        let cerrarButton = app.buttons["Cerrar"]
        cerrarButton.tap()
        
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["2"]/*[[".cells.buttons[\"2\"]",".buttons[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.images["card_2"].exists)
        cerrarButton.tap()
        collectionViewsQuery.buttons["40"].tap()
        XCTAssert(app.images["card_40"].exists)
        cerrarButton.tap()
        collectionViewsQuery.buttons["1"].tap()
        XCTAssert(app.images["card_1"].exists)
        cerrarButton.tap()
        collectionViewsQuery.buttons["13"].tap()
        XCTAssert(app.images["card_13"].exists)
        cerrarButton.tap()
        collectionViewsQuery.buttons["0,5"].tap()
        XCTAssert(app.images["card_0,5"].exists)
        cerrarButton.tap()
        let menButton = app.navigationBars["AutentiaScrumCards.MainView"].buttons["Menú"]
        menButton.tap()
        
    }
    
    func testShirtSizesCards() {
        let cerrarButton = app.buttons["Cerrar"]
        let menButton = app.navigationBars["AutentiaScrumCards.MainView"].buttons["Menú"]
        let collectionViewsQuery = app.collectionViews
        app.buttons["Tallas de camiseta"].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["∞"]/*[[".cells.buttons[\"∞\"]",".buttons[\"∞\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.images["card_∞"].exists)
        cerrarButton.tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.buttons["L"]/*[[".cells.buttons[\"L\"]",".buttons[\"L\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.images["card_L"].exists)
        cerrarButton.tap()
        collectionViewsQuery.buttons["XL"].tap()
        XCTAssert(app.images["card_XL"].exists)
        cerrarButton.tap()
        collectionViewsQuery.buttons["S"].tap()
        XCTAssert(app.images["card_S"].exists)
        cerrarButton.tap()
        collectionViewsQuery.buttons["M"].tap()
        XCTAssert(app.images["card_M"].exists)
        cerrarButton.tap()
        menButton.tap()
    }
    

    func testLowerButtons() {
        let cerrarButton = app.buttons["Cerrar"]
        let menButton = app.navigationBars["AutentiaScrumCards.MainView"].buttons["Menú"]
        let collectionViewsQuery = app.collectionViews
    
        app.buttons["Fibonacci"].tap()
    
        let cupButton = collectionViewsQuery.buttons["cup"]
        cupButton.tap()
        XCTAssert(app.images["restCard"].exists)
        cerrarButton.tap()
        
        let watchButton = collectionViewsQuery.buttons["watch"]
        watchButton.tap()
        XCTAssert(app.images["tooMuchTime"].exists)
        cerrarButton.tap()
        
        menButton.tap()
        app.buttons["Tallas de camiseta"].tap()
        cupButton.tap()
        XCTAssert(app.images["restCard"].exists)
        cerrarButton.tap()
        watchButton.tap()
        XCTAssert(app.images["tooMuchTime"].exists)
        cerrarButton.tap()
        menButton.tap()
        
    }

}
