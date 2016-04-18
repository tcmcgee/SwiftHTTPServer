//
//  HttpServer.swift
//  SwiftHTTPServer
//
//  Created by Tom McGee on 4/18/16.
//  Copyright © 2016 Tom McGee. All rights reserved.
//

import Foundation

class HTTPServer: NSObject {
    let defaultPort : UInt16 = 5000
    
    func prepareSocketAddress() -> sockaddr_in {
    var zeroAddress = sockaddr_in()
        zeroAddress.sin_port = defaultPort.bigEndian
    return zeroAddress
    }
}