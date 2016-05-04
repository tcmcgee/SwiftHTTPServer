class Request{
    
    var method = ""
    var URI : String? = ""
    var body: String?
    var baseURI: String? = ""
    var headerDictionary : Dictionary<String,String>?
    
    init(requestString : String) {
        let head = getHead(requestString: requestString)
        let statusLine = getStatusLine(head: head)
        
        method = getMethod(statusLine: statusLine)
        URI = getURI(statusLine: statusLine)
        let splitURI = split(string: URI!, separator: "?")
        if (splitURI.count > 1) {
            baseURI = splitURI[0]
        }
        else {
            baseURI = URI
        }
        headerDictionary = getHeaders(head: head)
       
        body = getBody(requestString: requestString)
        
    }
    
    func getHead(requestString: String) -> String {
        let requestArray = split(string: requestString, separator: "\r\n\r\n")
        return requestArray[0]
    }
    
    func getBody(requestString: String) -> String {
        let requestArray = split(string: requestString, separator: "\r\n\r\n")
        return requestArray[1]
    }
    
    func getStatusLine(head: String) -> String {
        let headArray = split(string: head, separator: "\r\n")
        
        return headArray[0]
    }
    
    func getMethod(statusLine: String) -> String {
        let statusLineArray = split(string:statusLine, separator: " ")
        
        return statusLineArray[0]
    }
    
    func getURI(statusLine: String) -> String {
        let statusLineArray = split(string:statusLine, separator: " ")

        return statusLineArray[1]
    }
    
    func getHTTPVersion(statusLine: String) -> String {
        let statusLineArray = split(string: statusLine, separator: " ")
        
        return statusLineArray[2]
    }
    
    func getHeaders(head: String) -> Dictionary<String, String> {
        var headArray = split(string: head, separator: "\r\n")
        headArray.remove(at: 0)
        let headerDictionary = getDictionaryFromHeaders(headerArray: headArray)
        
        return headerDictionary
    }
    
    func getDictionaryFromHeaders(headerArray: Array<String>) -> Dictionary<String,String> {
        var headerDictionary = Dictionary<String,String>()
        for header in headerArray {
            let splitHeader = split(string: header, separator: ": ")
            headerDictionary[splitHeader[0]] = splitHeader[1]
            
        }
        return headerDictionary
    }
    
    func getHeader(header: String) -> String {
        let value = headerDictionary!.get(key: header,defaultValue: "")
        return value
    }

    func split(string: String, separator: String) -> Array<String> {
            return string.components(separatedBy: separator)
    }
    
    
}