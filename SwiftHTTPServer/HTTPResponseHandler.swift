import Foundation

class HTTPResponseHandler: NSObject {
    
    func startResponse(request: Request, fileHandle: NSFileHandle?) {
        let responseGenerator = HTTPResponseGenerator()
        let response = responseGenerator.generateResponse(URI: request.URI, method: request.method, body: request.body)
        let responseString = response
        let responseData = responseString.data(using: NSUTF8StringEncoding, allowLossyConversion: false)!
        if let fileHandler = fileHandle{
            fileHandler.write(responseData)
        }
    }
}