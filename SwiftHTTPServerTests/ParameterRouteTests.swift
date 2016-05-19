//
//  ParameterRouteTests.swift
//  SwiftHTTPServer
//
//  Created by Tom McGee on 4/28/16.
//  Copyright © 2016 Tom McGee. All rights reserved.
//

import XCTest

class ParameterRouteTests: XCTestCase {

    let URIWithParams = "/parameters?variable_1=Operators%20%3C%2C%20%3E%2C%20%3D%2C%20!%3D%3B%20%2B%2C%20-%2C%20*%2C%20%26%2C%20%40%2C%20%23%2C%20%24%2C%20%5B%2C%20%5D%3A%20%22is%20that%20all%22%3F&variable_2=stuff"
    
    let paramsRoute = ParameterRoute(allowedMethods: "GET,OPTIONS")
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetAllowedMethods() {
        let expectedAllowedMethods = ["GET","OPTIONS"]
        let allowedMethods = paramsRoute.getAllowedMethods()
        
        XCTAssertEqual(expectedAllowedMethods, allowedMethods)
    }
    
    func testIsAllowedMethods() {
        XCTAssert(paramsRoute.isAllowedMethod(method: "OPTIONS"))
    }
    
    func testExtensionOfBasicRouteReturnsCorrectOptionsHeader() {
        let headers = paramsRoute.getResponseHeaders(uri: "/_", method: "OPTIONS", requestBody: "")
        
        XCTAssertEqual(headers["Allow"],"GET,OPTIONS")
    }

    func testGetResponseBody() {
        let expectedResults = "variable_1 = Operators <, >, =, !=; +, -, *, &, @, #, $, [, ]: \"is that all\"? variable_2 = stuff"
        let responseBody = paramsRoute.getResponseBody(uri: URIWithParams, method: "GET", requestHeaders: Dictionary<String,String>(), requestBody: "")
        let responseBodyString = NSString(bytes: responseBody,length: responseBody.count, encoding: NSUTF8StringEncoding)
        XCTAssertEqual(responseBodyString, expectedResults)
    }


}
