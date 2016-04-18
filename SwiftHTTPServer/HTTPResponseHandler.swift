import Foundation

class HTTPResponseHandler: NSObject {
    var fileHandle: NSFileHandle?
    var requestURL = NSURL(string: "")
    var method = ""
    var bodyData: NSData?
    
    func parseRequest(request: CFHTTPMessage, fileHandle: NSFileHandle){
     self.fileHandle = fileHandle
     self.requestURL = getRequestURL(request: request)
     self.method = getRequestMethod(request: request)
     self.bodyData = getRequestBodyData(request: request)
    }
    
    func startResponse(){
        
        print("\(method) + ---- \(requestURL)\n")
        var response = CFHTTPMessageCreateResponse(kCFAllocatorDefault, 501, nil, kCFHTTPVersion1_1)
        if (method == "GET" || method == "OPTIONS" || method == "POST" || method == "PUT"){
            response = CFHTTPMessageCreateResponse(kCFAllocatorDefault, 200, nil, kCFHTTPVersion1_1)
            CFHTTPMessageSetHeaderFieldValue(response.takeUnretainedValue() , "Content-Type", "text/html")
             if (method == "OPTIONS")
            {
                if (requestURL?.relativePath! == "/method_options"){
                    CFHTTPMessageSetHeaderFieldValue(response.takeUnretainedValue(), "Allow", "GET,HEAD,POST,OPTIONS,PUT")
                }
                else{
                    CFHTTPMessageSetHeaderFieldValue(response.takeUnretainedValue(), "Allow", "GET")
                }
            }

            let bodyString = ("This was a \(method) request for \(requestURL!)\n")
            CFHTTPMessageSetBody(response.takeUnretainedValue(), bodyString.data(using: NSUTF8StringEncoding)!)
        }
            
        else {
            let bodyString = "404 - Not Found"
            CFHTTPMessageSetBody(response.takeUnretainedValue(), bodyString.data(using: NSUTF8StringEncoding)!)
        }

        let responseData = CFHTTPMessageCopySerializedMessage(response.takeUnretainedValue())
        if let fileHandler = fileHandle{
            fileHandler.write(responseData!.takeUnretainedValue())
        }
    }

    func getRequestURL(request: CFHTTPMessage) -> NSURL{
        return CFHTTPMessageCopyRequestURL(request)!.takeUnretainedValue()
    }
    func getRequestMethod(request: CFHTTPMessage) -> String{
        return CFHTTPMessageCopyRequestMethod(request)!.takeUnretainedValue() as String
    }
    func getRequestBodyData(request: CFHTTPMessage) -> NSData?{
        let bodyCFData = CFHTTPMessageCopyBody(request)!.takeRetainedValue()
        return bodyCFData as NSData
    }
}