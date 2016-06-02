import Foundation

class BasicRoute: Route {
    
    var allowedMethods: [HTTPMethods]
    var contentLength = 0
    
    required init(allowedMethods: [HTTPMethods]) {
        self.allowedMethods = allowedMethods
    }
    
    func getAllowedMethods() -> [HTTPMethods]{
        return allowedMethods
    }
    
    func isAllowedMethod(method: String) -> Bool {
        return contains(allowedMethods: getAllowedMethods(), method: method)
    }
    
    func getResponseBody(uri: String, method: String, requestHeaders: Dictionary<String,String>, requestBody: String?) -> [UInt8] {
        let bodyString: String = isAllowedMethod(method: method) ? "\(method) for \(uri)" : "405 - Method Not Allowed"
        return removeNullBytes(byteArray: getByteArrayFromString(string: bodyString))
    }
    
    func getResponseHeaders(uri: String, method: String, requestBody: String?) -> Dictionary<String,String> {
        var headers : Dictionary<String,String> = Dictionary<String,String>()

        headers["Content-Type"] = "text/html"
        if (method == "OPTIONS") {
            headers["Allow"] = joined(allowedMethods: allowedMethods, separator: ",")
        }
        return headers
    }
    
    func getResponseStatusCode(method: String) -> String {
        let statusCode: String = isAllowedMethod(method: method) ? "200" : "405"
        return statusCode
    }
    
    func removeNullBytes(byteArray: [UInt8]) -> [UInt8] {
        var trimmedArray = [UInt8]()
        for byte in byteArray {
            if (byte != 0) {
                trimmedArray.append(byte)
            }
        }
        return trimmedArray
    }
    
    func getByteArrayFromString(string: String) -> [UInt8] {
        contentLength = 0
        var myArray = [UInt8]()
        let myCString = string.cString(using: NSUTF8StringEncoding)
        for char in myCString! {
            contentLength += 1
            myArray.append(UInt8(char))
        }
        return myArray
    }
    
    func contains(allowedMethods: [HTTPMethods], method: String) -> Bool{
        for httpMethod in allowedMethods {
            if (httpMethod.rawValue == method)
            {
                return true
            }
        }
        return false
    }
    
    func joined(allowedMethods: [HTTPMethods], separator: String) -> String {
        var string = ""
        var count = 0
        for method in allowedMethods {
            string += method.rawValue
            if (count != allowedMethods.count - 1) {
                string += separator + " "
            }
            count = count + 1
        }
        
        return string
    }
    
}