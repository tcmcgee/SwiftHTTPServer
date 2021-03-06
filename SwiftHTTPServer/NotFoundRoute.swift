class NotFoundRoute: BasicRoute {
    override func getResponseBody(uri: String, method: HTTPMethods, requestHeaders: Dictionary<String, String>, requestBody: String?) -> [UInt8] {
        return removeNullBytes(byteArray: getByteArrayFromString(string: "404 - Not Found"))

    }
    
    override func getResponseStatusCode(method: HTTPMethods) -> String {
        return "404"
    }
    
}