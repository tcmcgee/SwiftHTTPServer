class FileServingRoute: BasicRoute {
    
    var statusCode = "200"
    
    override func getResponseBody(uri: String, method: String, requestHeaders: Dictionary<String,String>, requestBody: String?) -> [UInt8] {
        let fileOperations = FileOperations(file: uri, pathToDir: Configuration.publicDirectory)
        let range = requestHeaders.get(key: "Range", defaultValue: "")
        
        let contents: [UInt8]
        if (range == "") {
            contents = fileOperations.Read()
        } else {
            statusCode = "206"
            let startIndex = getRangeIndex(range: range, beginning: true)
            let endIndex = getRangeIndex(range: range, beginning: false)
            contents = fileOperations.ReadPartial(start: startIndex, end: endIndex)
        }
        
        return contents
    }
    
    override func getResponseHeaders(uri: String, method: String, requestBody: String?) -> Dictionary<String,String> {
        var headers : Dictionary<String,String> = Dictionary<String,String>()
        
        if (method == "OPTIONS") {
            headers["Allow"] = allowedMethods!.joined(separator: ",")
        }
        return headers
    }
    
    override func getResponseStatusCode(method: String) -> String {
        if (isAllowedMethod(method: method)){
            return statusCode
        } else {
            return "405"
        }
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