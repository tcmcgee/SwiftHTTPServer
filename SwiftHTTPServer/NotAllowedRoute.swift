class NotAllowedRoute: BasicRoute {
    override func getResponseBody(uri: String, method: HTTPMethods, requestHeaders: Dictionary<String, String>, requestBody: String?) -> [UInt8] {
        return removeNullBytes(byteArray: getByteArrayFromString(string: "405 - Method Not Allowed"))
        
    }
    
    override func getResponseStatusCode(method: HTTPMethods) -> String {
        return "405"
    }
    
}