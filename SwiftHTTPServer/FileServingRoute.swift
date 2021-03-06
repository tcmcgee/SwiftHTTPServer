class FileServingRoute: BasicRoute {
    
    var statusCode = "200"
    var eTag: String? = nil
    override func getResponseBody(uri: String, method: HTTPMethods, requestHeaders: Dictionary<String,String>, requestBody: String?) -> [UInt8] {
        let fileOperations = FileOperations(file: uri, pathToDir: Configuration.publicDirectory)
        let contents: [UInt8]
        if (method == .Get) {
            let range = requestHeaders.get(key: "Range", defaultValue: "")
            
            if (range == "") {
                contents = fileOperations.read()
            } else {
                contents = getPartialContent(fileOperations: fileOperations, range: range)
            }
        } else if (method == .Patch) {
            statusCode = "204"
            fileOperations.write(string: requestBody!)
            eTag = requestHeaders.get(key: "If-Match", defaultValue: "")
            contents = super.getResponseBody(uri: uri, method: method, requestHeaders: requestHeaders, requestBody: requestBody)
        } else {
            contents = super.getResponseBody(uri: uri, method: method, requestHeaders: requestHeaders, requestBody: requestBody)
        }
        return contents
    }
    
    override func getResponseHeaders(uri: String, method: HTTPMethods, requestBody: String?) -> Dictionary<String,String> {
        var headers : Dictionary<String,String> = Dictionary<String,String>()
        if (method == .Patch){
            headers["ETag"] = eTag!
        }
        return headers
    }
    
    override func getResponseStatusCode(method: HTTPMethods) -> String {
        return statusCode
    }
    
    func getPartialContent(fileOperations: FileOperations, range: String) -> [UInt8]{
        statusCode = "206"
        let startIndex = getRangeIndex(range: range, beginning: true)
        let endIndex = getRangeIndex(range: range, beginning: false)
        
        if ((endIndex < startIndex || startIndex < 0 || endIndex < 0) && endIndex != -2) {
            statusCode = "416"
        }
        
        return fileOperations.readPartial(start: startIndex, end: endIndex)
    }
    
    
    func getRangeIndex(range: String, beginning: Bool ) -> Int {
        let rangeString: String = String(range.characters.split(separator: "=")[1])
        
        var start = true
        var indexString = ""
        
        for char in rangeString.characters {
            if (char == "-") {
                start = false
            }
            else if (start) {
                if (beginning){
                    indexString += String(char)
                }
            }
            else {
                if (!beginning){
                    indexString += String(char)
                }
            }
        }
        
        
        var index = 0
        if (indexString != "") {
            index = Int(indexString)!
        }
        
        if (indexString == "" && !beginning) {
            index = -2
        }
        
        return index
    }

}