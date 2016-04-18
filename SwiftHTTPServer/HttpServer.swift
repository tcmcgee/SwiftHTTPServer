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
    
    func start(){
        if let socket = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP,0, nil, nil){
            let nativeSocket = CFSocketGetNative(socket)
            var reuse = true
            if setsockopt(nativeSocket, SOL_SOCKET, SO_REUSEADDR, &reuse, socklen_t(sizeof(Int32))) != 0 {
                print("ERROR SETTING SOCKET OPTIONS")
                return
            }
            var address: sockaddr_in = prepareSocketAddress()
            let bindingSocketSuccess = bindSocket(socket: socket, pointer: &address)
            if (!bindingSocketSuccess){
                print("UNABLE TO BIND SOCKET")
                return
            }
            
        }
    }
    
    func prepareSocketAddress() -> sockaddr_in {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        zeroAddress.sin_port = defaultPort.bigEndian
        return zeroAddress
    }
    
    func bindSocket(socket : CFSocket, pointer : UnsafePointer<sockaddr_in>) -> Bool {
        let socketAddressData = CFDataCreate(nil, UnsafePointer<UInt8>(pointer), sizeof(sockaddr_in))
        return CFSocketSetAddress(socket, socketAddressData) == CFSocketError.success
    }
    
}