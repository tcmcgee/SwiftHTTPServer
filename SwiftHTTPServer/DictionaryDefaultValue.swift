//
//  DictionaryDefaultValue.swift
//  SwiftHTTPServer
//
//  Created by Tom McGee on 4/28/16.
//  Copyright © 2016 Tom McGee. All rights reserved.
//

import Foundation
extension Dictionary {
    func get(key: Key, defaultValue: Value) -> Value {
        if let value = self[key] {
            return value
        } else {
            return defaultValue
        }
    }
}