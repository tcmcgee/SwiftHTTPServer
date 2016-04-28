//
//  FormRouteTests.swift
//  SwiftHTTPServer
//
//  Created by Tom McGee on 4/28/16.
//  Copyright © 2016 Tom McGee. All rights reserved.
//

import XCTest

class FormRouteTests: XCTestCase {
    let fileManager = NSFileManager()
    let file = "testRoute.txt"
    var formRoute = FormRoute(allowedMethods: "GET,OPTIONS,POST,PUT,DELETE")
    
    override func tearDown() {
        super.tearDown()
        formRoute.getResponseBody(uri: "/form", method: "DELETE", requestBody: "")
    }
    
    func testGetResponseBody() {
        formRoute.getResponseBody(uri: "/form", method: "POST", requestBody:"Howdy")
        
        let fileContents = formRoute.getResponseBody(uri: "/form", method: "GET", requestBody:"")
        
        XCTAssertEqual("Howdy",fileContents)
    }
    
}
