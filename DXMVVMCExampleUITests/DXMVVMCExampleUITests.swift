//
//  DXMVVMCExampleUITests.swift
//  DXMVVMCExampleUITests
//
//  Created by Yasir Romaya on 8/29/22.
//

import XCTest

class DXMVVMCExampleUITests: XCTestCase {

    override func setUp() {
        super.setUp()
    
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    func testExample() {
        XCUIDevice.shared.orientation = .portrait
        
        snapshot("0Launch")
    }
}
