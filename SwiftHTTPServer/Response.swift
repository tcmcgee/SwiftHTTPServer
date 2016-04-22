//
//  Response.swift
//  SwiftHTTPServer
//
//  Created by Tom McGee on 4/20/16.
//  Copyright © 2016 Tom McGee. All rights reserved.
//

import Foundation

class Response {
    var response: String = ""
    
    func setResponse(response: String) {
        self.response = response
    }
    
    func getResponse() -> String {
        return response
    }
}