import Foundation

class Response {
    var response: String = ""
    var statusCode: String = "200"
    var HTTPVersion: String = "HTTP/1.1"
    var body = [UInt8]()
    var byteResponse = [UInt8]()
    let CRLF = "\r\n"
    var headers: Dictionary<String,String> = Dictionary<String,String>()
    var reasonPhrases: Dictionary<String,String> = Dictionary<String, String>()
    var responseLength = 0
    
    init() {
        buildReasonPhrases()
    }
    
    func buildReasonPhrases() {
        reasonPhrases["200"] = "OK"
        reasonPhrases["206"] = "Partial Content"
        reasonPhrases["302"] = "See Other"
        reasonPhrases["404"] = "Not Found"
        reasonPhrases["405"] = "Not Allowed"
        reasonPhrases["501"] = "Not Implemented"
    }
    
    func GetHTTPResponse() -> [UInt8] {
        response += getStatusLine()
        response += getHeadersString()
        
        byteResponse = getByteArrayFromString(string: response)
        byteResponse += body
        return byteResponse
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

    func getBody() -> [UInt8] {
        return body
    }
    
    func setBody(body: [UInt8]) {
        self.body = body
    }
    
    func getByteArrayFromString(string: String) -> [UInt8] {
        responseLength = -1
        var myArray = [UInt8]()
        let myCString = string.cString(using: NSUTF8StringEncoding)
        for char in myCString! {
            responseLength += 1
            if (UInt8(char) != 0) {
                myArray.append(UInt8(char))
            }
        }
        return myArray
    }

    
}