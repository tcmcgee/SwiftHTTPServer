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
    
    func testGetStatusLine(){
        let head = "POST / HTTP/1.1\r\nHost: localhost:5000\r\nUser-Agent: curl/7.43.0\r\nAccept: */*\r\nContent-Length: 13\r\nContent-Type: application/x-www-form-urlencoded"
        
        let statusLine = request!.getStatusLine(head: head)
        
        XCTAssertEqual(statusLine, "POST / HTTP/1.1")
    }
    
    func testGetMethod(){
        let statusLine = "POST / HTTP/1.1"
        
        let method = request!.getMethod(statusLine: statusLine)
        
        XCTAssertEqual(method, "POST")
    }
    
    func testGetURI(){
        let statusLine = "POST /coleslaw HTTP/1.1"
        
        let URI = request!.getURI(statusLine: statusLine)
        
        XCTAssertEqual(URI, "/coleslaw")
    }
    
    func testGetHTTPVersion(){
        let statusLine = "POST / HTTP/1.1"
        
        let URI = request!.getHTTPVersion(statusLine: statusLine)
        
        XCTAssertEqual(URI, "HTTP/1.1")
    }
    
    func testGetHeaders(){
        let head = "POST / HTTP/1.1\r\nHost: localhost:5000\r\nContent-Length: 13"
        var expectedHeaderDictionary : Dictionary<String,String> = Dictionary<String,String>()
        expectedHeaderDictionary["Host"] = "localhost:5000"
        expectedHeaderDictionary["Content-Length"] = "13"
        
        let headers = request!.getHeaders(head: head)
        
        XCTAssertEqual(headers, expectedHeaderDictionary)
    }
    
    func testGetHeader(){
        var expectedHeaderDictionary : Dictionary<String,String> = Dictionary<String,String>()
        expectedHeaderDictionary["Host"] = "localhost:5000"
        expectedHeaderDictionary["Content-Length"] = "13"
        
        let contentLength = request!.getHeader(header: "Content-Length")
        
        XCTAssertEqual(contentLength, "13")
    }
    
}
