//
//  RequestTests.swift
//  SwiftHTTPServer
//
//  Created by Tom McGee on 4/20/16.
//  Copyright © 2016 Tom McGee. All rights reserved.
//

import XCTest

class RequestTests: XCTestCase {
    
    let requestString = "POST / HTTP/1.1\r\nHost: localhost:5000\r\nUser-Agent: curl/7.43.0\r\nAccept: */*\r\nContent-Length: 13\r\nContent-Type: application/x-www-form-urlencoded\r\n\r\nparam1=value1"
    
    var request : Request?

    override func setUp() {
        super.setUp()
        request = Request(requestString: requestString)
    }
    
    func testGetBody() {
        let body = request!.getBody(requestString: requestString)
        
        XCTAssertEqual(body, "param1=value1")
    }
    
    func testGetHead() {
        let header = request!.getHead(requestString: requestString)
        
        XCTAssertEqual(header, "POST / HTTP/1.1\r\nHost: localhost:5000\r\nUser-Agent: curl/7.43.0\r\nAccept: */*\r\nContent-Length: 13\r\nContent-Type: application/x-www-form-urlencoded")
    }
    
    func testGetStatusLine(head: String){
        let head = "POST / HTTP/1.1\r\nHost: localhost:5000\r\nUser-Agent: curl/7.43.0\r\nAccept: */*\r\nContent-Length: 13\r\nContent-Type: application/x-www-form-urlencoded"
        
        let statusLine = request!.getStatusLine(head: head)
        
        XCTAssertEqual(statusLine, "POST / HTTP/1.1")
    }

}
