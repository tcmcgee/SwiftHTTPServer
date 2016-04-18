//
//  SwiftHTTPServerTests.swift
//  SwiftHTTPServerTests
//
//  Created by Tom McGee on 4/18/16.
//  Copyright © 2016 Tom McGee. All rights reserved.
//

import XCTest

class SwiftHTTPServerTests: XCTestCase {
    var server = HTTPServer()
    
    
    
    func testDefaultPort() {
        XCTAssertEqual(5000, server.defaultPort)
    }
    
    
}
