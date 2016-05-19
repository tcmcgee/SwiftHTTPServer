class NotFoundRoute: BasicRoute {
    
    override func getResponseBody(uri: String, method: String, requestHeaders: Dictionary<String,String>, requestBody: String?) -> [UInt8] {
        return removeNullBytes(byteArray: getByteArrayFromString(string: "404 - Not Found"))
    }
    
    override func getResponseStatusCode(method: String) -> String {
        return "404"
    }
    
}