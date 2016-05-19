//
//  NotFoundRouteTests.swift
//  SwiftHTTPServer
//
//  Created by Tom McGee on 4/28/16.
//  Copyright © 2016 Tom McGee. All rights reserved.
//

import XCTest

class NotFoundRouteTests: XCTestCase {

    func testGetBody() {
        let route = NotFoundRoute(allowedMethods: "GET")
        let expectedResponseBody = ("404 - Not Found")
        
        let responseBody = route.getResponseBody(uri: "/testing123", method: "GET", requestHeaders: Dictionary<String,String>(), requestBody: nil)
        let responseString = NSString(bytes: responseBody,length: responseBody.count, encoding: NSUTF8StringEncoding)
        print("\(expectedResponseBody) \(responseString)")
        XCTAssertEqual(expectedResponseBody, responseString!)
    }
    
    func testGetResponseStatusCode() {
        let route = NotFoundRoute(allowedMethods: "GET,OPTIONS")
        let expectedResponseCode = "404"
        
        XCTAssertEqual(expectedResponseCode, route.getResponseStatusCode(method: "_"))
    }

}