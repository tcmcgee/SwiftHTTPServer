class RedirectRoute: BasicRoute {
    
    override func getResponseStatusCode(method: String) -> String {
        return "302"
    }
    
    override func getResponseHeaders(uri: String, method: String, requestBody: String?) -> Dictionary<String,String> {
        var headers : Dictionary<String,String> = Dictionary<String,String>()
        headers["Location"] = "http://localhost:5000/"
        if (method == "OPTIONS") {
            headers["Allow"] = joined(allowedMethods: allowedMethods, separator: ",")
        }
        
        return headers
    }


}
