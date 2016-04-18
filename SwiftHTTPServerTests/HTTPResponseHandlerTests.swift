//
//  HTTPResponseHandlerTests.swift
//  SwiftHTTPServer
//
//  Created by Tom McGee on 4/18/16.
//  Copyright © 2016 Tom McGee. All rights reserved.
//

import XCTest

class HTTPResponseHandlerTests: XCTestCase {
    var request : CFHTTPMessage?
    var fakeHandle = NSFileHandle()
    var requestURL : NSURL?
    
    override func setUp() {
        super.setUp()
        requestURL = CFURLCreateWithString(kCFAllocatorDefault, "/Taco", nil )
        request = CFHTTPMessageCreateRequest(kCFAllocatorDefault, "GET", requestURL! , kCFHTTPVersion1_0).takeRetainedValue()
        CFHTTPMessageSetBody(request!, CFDataCreate(nil,nil,0))
    }
    
    func testGetMethod(){
        let responseHandler = HTTPResponseHandler()
        
        XCTAssertEqual(responseHandler.getRequestMethod(request: request!), "GET")
    }
    
    func testGetURL(){
        let responseHandler = HTTPResponseHandler()
        
        XCTAssertEqual(responseHandler.getRequestURL(request: request!), requestURL!)
    }
    
    func testGetBodyData(){
        let responseHandler = HTTPResponseHandler()
        let nilData = CFDataCreate(nil,nil,0)
        
        XCTAssertEqual(responseHandler.getRequestBodyData(request: request!), nilData)
    }
    
    
    


}
