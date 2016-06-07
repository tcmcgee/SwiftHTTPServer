protocol Route {

    func getResponseHeaders(uri: String, method: HTTPMethods, requestBody: String?) -> Dictionary<String,String>
    func getResponseBody(uri: String, method: HTTPMethods, requestHeaders: Dictionary<String,String>, requestBody: String?) -> [UInt8]
    func getResponseStatusCode(method: HTTPMethods) -> String
}

