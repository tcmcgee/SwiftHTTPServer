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
        var response : CFHTTPMessage?
        if (method == "GET" || method == "OPTIONS"){
            CFHTTPMessageCreateResponse(kCFAllocatorDefault, 200, nil, kCFHTTPVersion1_1)
            CFHTTPMessageSetHeaderFieldValue(response!, "Content-Type", "text/html")
            
            if (method == "OPTIONS")
            {
                if (requestURL?.relativePath! == "/method_options"){
                    CFHTTPMessageSetHeaderFieldValue(response!, "Allow", "GET,HEAD,POST,OPTIONS,PUT")
                }
                else{
                    CFHTTPMessageSetHeaderFieldValue(response!, "Allow", "GET")
                }
            }

            let bodyString = ("This was a \(method) request for \(requestURL)\n")
            CFHTTPMessageSetBody(response!, bodyString.data(using: NSUTF8StringEncoding)!)
        }
            
        else {
            CFHTTPMessageCreateResponse(kCFAllocatorDefault, 501, nil, kCFHTTPVersion1_1)
            let bodyString = "501 - Method not yet implemented"
            CFHTTPMessageSetBody(response!, bodyString.data(using: NSUTF8StringEncoding)!)
        }

        let responseData = CFHTTPMessageCopySerializedMessage(response!)
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