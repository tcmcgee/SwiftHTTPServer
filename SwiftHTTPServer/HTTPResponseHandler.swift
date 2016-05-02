import Foundation

class HTTPResponseHandler: NSObject {
    
    func getResponse(request: Request) -> String {
        let responseGenerator = HTTPResponseGenerator()
        let response = responseGenerator.generateResponse(URI: request.URI, baseURI: request.baseURI!, method: request.method, body: request.body)
        let responseString = response
        return responseString
    }
    
    func getData(string: String) -> NSData {
        return string.data(using:NSUTF8StringEncoding, allowLossyConversion: false)!
    }
    
    func sendResponse(responseData: NSData, fileHandle: NSFileHandle?) -> Bool {
        if let fileHandler = fileHandle {
            fileHandler.write(responseData)
            return true
        }
        return false
    }
}