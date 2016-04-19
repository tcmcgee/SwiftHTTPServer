import Foundation

class HTTPResponseHandler: NSObject {
    var fileHandle: NSFileHandle?
    var requestURL = NSURL(string: "")
    var method = ""
    var URI : String? = ""
    var bodyData: NSData?
    
    func parseRequest(request: CFHTTPMessage, fileHandle: NSFileHandle){
     self.fileHandle = fileHandle
     self.requestURL = getRequestURL(request: request)
     self.URI = requestURL?.relativePath
     self.method = getRequestMethod(request: request)
     self.bodyData = getRequestBodyData(request: request)
    }
    
    func startResponse(){
        let responseGenerator = HTTPResponseGenerator()
        let response = responseGenerator.generateResponse(URI: URI, method: method, bodyData: bodyData)
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