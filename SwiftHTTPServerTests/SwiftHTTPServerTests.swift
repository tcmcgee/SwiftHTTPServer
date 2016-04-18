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
    
    func testPrepareSocketAddressPort(){
        let socketAddress : sockaddr_in = server.prepareSocketAddress()
        let expectedPort : UInt16 = 5000
        
        XCTAssertEqual(expectedPort.bigEndian, socketAddress.sin_port)
    }
    
    func testPrepareSocketAddressIsLocalHost(){
        let socketAddress : sockaddr_in = server.prepareSocketAddress()
        let expectedAddress : UInt32 = 0 
        
        XCTAssertEqual(expectedAddress.bigEndian, socketAddress.sin_addr.s_addr)
    }
    
    
}
