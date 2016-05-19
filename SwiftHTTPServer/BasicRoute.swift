import Foundation

class BasicRoute: Route {
    
    var allowedMethods: [String]?
    var contentLength = 0
    
    required init(allowedMethods: String) {
        self.allowedMethods = allowedMethods.components(separatedBy: ",")
    }
    
    func getAllowedMethods() -> [String]{
        return allowedMethods!
    }
    
    func isAllowedMethod(method: String) -> Bool {
        return getAllowedMethods().contains(method)
    }
    
    func getResponseBody(uri: String, method: String, requestBody: String?) -> [UInt8] {
        let bodyString: String = isAllowedMethod(method: method) ? "\(method) for \(uri)" : "405 - Method Not Allowed"
        return removeNullBytes(byteArray: getByteArrayFromString(string: bodyString))
    }
    
    func getResponseHeaders(uri: String, method: String, requestBody: String?) -> Dictionary<String,String> {
        var headers : Dictionary<String,String> = Dictionary<String,String>()

        headers["Content-Type"] = "text/html"
        if (method == "OPTIONS") {
            headers["Allow"] = allowedMethods!.joined(separator: ",")
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
    
}