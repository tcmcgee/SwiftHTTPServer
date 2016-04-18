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
    
    func testPrepareSocketAddressDefaultSinFamily(){
        let socketAddress : sockaddr_in = server.prepareSocketAddress()
        let expectedFamily = sa_family_t(AF_INET)
        
        XCTAssertEqual(expectedFamily, socketAddress.sin_family)
        
    }
    
    func testPrepareSocketAddressLength(){
        let socketAddress : sockaddr_in = server.prepareSocketAddress()
        let expectedLength = UInt8(16)
        
        XCTAssertEqual(expectedLength, socketAddress.sin_len)
    }
    
    
}
