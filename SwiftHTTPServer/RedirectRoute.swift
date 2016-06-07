class RedirectRoute: BasicRoute {
    
    override func getResponseStatusCode(method: HTTPMethods) -> String {
        return "302"
    }
    
    override func getResponseHeaders(uri: String, method: HTTPMethods, requestBody: String?) -> Dictionary<String,String> {
        var headers : Dictionary<String,String> = Dictionary<String,String>()
        headers["Location"] = "http://localhost:5000/"
        
        return headers
    }


}
