import Foundation

class BasicRoute: Route {
    
    func getResponseBody(uri: String, method: HTTPMethods, requestHeaders: Dictionary<String,String>, requestBody: String?) -> [UInt8] {
        let bodyString: String = "\(method.rawValue) for \(uri)"
        return removeNullBytes(byteArray: getByteArrayFromString(string: bodyString))
    }
    
    func getResponseHeaders(uri: String, method: HTTPMethods, requestBody: String?) -> Dictionary<String,String> {
        var headers : Dictionary<String,String> = Dictionary<String,String>()

        headers["Content-Type"] = "text/html"
        return headers
    }
    
    func getResponseStatusCode(method: HTTPMethods) -> String {
        let statusCode: String = "200"
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
        var myArray = [UInt8]()
        let myCString = string.cString(using: NSUTF8StringEncoding)
        for char in myCString! {
            myArray.append(UInt8(char))
        }
        return myArray
    }
    
    func contains(allowedMethods: [HTTPMethods], method: HTTPMethods) -> Bool {
        return allowedMethods.contains { ele in
            ele.rawValue == method.rawValue
        }
    }
    
    func joined(allowedMethods: [HTTPMethods], separator: String) -> String {
        var string = ""
        var count = 0
        for method in allowedMethods {
            count = count + 1
            string += method.rawValue
            if (count != allowedMethods.count) {
                string += separator
            }
        }
        
        return string
    }
    
}