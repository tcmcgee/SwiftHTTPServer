import Foundation

class BasicAuthRoute: BasicRoute {
    
    final let credentials = "admin:hunter2"
    
    var statusCode = "200"
    
    override func getResponseBody(uri: String, method: String, requestHeaders: Dictionary<String, String>, requestBody: String?) -> [UInt8] {
        var content = [UInt8]()
        let authorized = getAuthorized(requestHeaders: requestHeaders)
        
        if (authorized) {
            let fileOperations = FileOperations(file:"/log.txt", pathToDir: Configuration.logDirectory)
            content = fileOperations.read()
        } else {
            statusCode = "401"
        }
        
        return content
    }
    
    override func getResponseHeaders(uri: String, method: String, requestBody: String?) -> Dictionary<String, String> {
        var headers = Dictionary<String,String>()
        if (statusCode != "200"){
            headers["WWW-Authenticate"] =  "Basic realm=\"Naperville\""
        }
        return headers
    }
    
    override func getResponseStatusCode(method: String) -> String {
        return statusCode
    }
    
    func getAuthorized(requestHeaders: Dictionary<String, String>) -> Bool{
        let authorizationHeader = requestHeaders.get(key: "Authorization", defaultValue: "")
        if (authorizationHeader == "") {
            return false
        } else {
            let splitAuthorizationHeader = String(authorizationHeader.characters.split(separator: " ")[1])
            let decodedAuthorizationHeader = decodeBase64(base64: splitAuthorizationHeader)
            return decodedAuthorizationHeader == credentials
        }
    }
    
    func decodeBase64(base64: String) -> String {
        let data = NSData(base64Encoded: base64, options: NSDataBase64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: data!, encoding: NSUTF8StringEncoding)
        return decodedString as! String
    }
}