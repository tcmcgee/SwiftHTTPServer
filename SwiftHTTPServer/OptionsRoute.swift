class OptionsRoute: BasicRoute {
    var allowedMethods: [HTTPMethods]
    init(allowedMethods: [HTTPMethods]) {
        self.allowedMethods = allowedMethods
    }
    override func getResponseHeaders(uri: String, method: HTTPMethods, requestBody: String?) -> Dictionary<String, String> {
        var headers = super.getResponseHeaders(uri: uri, method: method, requestBody: requestBody)
        headers["Allow"] = joined(allowedMethods: allowedMethods, separator: ",")
        return headers
    }
    
}