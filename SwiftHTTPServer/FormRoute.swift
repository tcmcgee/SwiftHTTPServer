//
//  FormRoute.swift
//  SwiftHTTPServer
//
//  Created by Tom McGee on 4/28/16.
//  Copyright © 2016 Tom McGee. All rights reserved.
//

import Foundation


class FormRoute: BasicRoute {
    
    override func getResponseBody(uri: String, method: String, requestBody: String?) -> String {
        let formData = FormData()
        var formBody = ""
        if (method == "POST" || method == "PUT" || method == "DELETE") {
            formData.formAction(method: method, body: requestBody!)
            formBody = super.getResponseBody(uri: uri, method: method, requestBody: requestBody)
        } else if (method == "GET") {
            formBody = formData.Read()
        }
        return formBody
    }
}
