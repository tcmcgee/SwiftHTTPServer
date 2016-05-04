class Response {
    var response: String = ""
    var statusCode: String = "200"
    var HTTPVersion: String = "HTTP/1.1"
    var body = ""
    let CRLF = "\r\n"
    var headers: Dictionary<String,String> = Dictionary<String,String>()
    var reasonPhrases: Dictionary<String,String> = Dictionary<String, String>()
    
    init() {
        buildReasonPhrases()
    }
    
    func buildReasonPhrases() {
        reasonPhrases["200"] = "OK"
        reasonPhrases["302"] = "See Other"
        reasonPhrases["404"] = "Not Found"
        reasonPhrases["405"] = "Not Allowed"
        reasonPhrases["501"] = "Not Implemented"
    }
    
    func GetHTTPResponse() -> String {
        response += getStatusLine()
        response += getHeadersString()
        response += getBody()
        
        return response
    }
    
    func getStatusLine() -> String {
        return HTTPVersion + " " + statusCode + " " + reasonPhrases[statusCode]! + CRLF
    }
    
    func getHeadersString() -> String {
        var headersString = ""
        for (header, value) in headers {
            headersString += header + ": " + value + CRLF
        }
        headersString += CRLF
        return headersString
    }
    
    func setResponse(response: String) {
        self.response = response
    }
    
    func getResponse() -> String {
        return response
    }
    
    func setStatusCode(statusCode: String) {
        self.statusCode = statusCode
    }
    
    func getStatusCode() -> String {
        return statusCode
    }
    
    func setHeader(header: String, value: String) {
        headers[header] = value
    }
    
    func getHeader(header: String) -> String {
        let value = headers[header] ?? "DNE"
        return value
    }
    
    func getHTTPVersion() -> String {
        return HTTPVersion
    }
    
    func setHTTPVersion(httpVersion: String) {
        HTTPVersion = httpVersion
    }

    func getBody() -> String {
        return body
    }
    
    func setBody(body: String) {
        self.body = body
    }
    
}