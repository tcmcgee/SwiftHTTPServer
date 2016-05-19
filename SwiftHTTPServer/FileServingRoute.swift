class FileServingRoute: BasicRoute {
    
    override func getResponseBody(uri: String, method: String, requestBody: String?) -> [UInt8] {
        let fileOperations = FileOperations(file: uri, pathToDir: Configuration.publicDirectory)
        
        let contents = fileOperations.Read()
        
        return contents
    }
    
    override func getResponseHeaders(uri: String, method: String, requestBody: String?) -> Dictionary<String,String> {
        var headers : Dictionary<String,String> = Dictionary<String,String>()
        
        if (method == "OPTIONS") {
            headers["Allow"] = allowedMethods!.joined(separator: ",")
        }
        return headers
    }

}