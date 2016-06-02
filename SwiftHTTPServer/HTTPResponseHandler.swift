import Foundation

class HTTPResponseHandler: NSObject {
    
    func getResponse(request: Request) -> [UInt8] {
        let responseGenerator = HTTPResponseGenerator()
        let response = responseGenerator.generateResponse(URI: request.URI, baseURI: request.baseURI!, method: request.method!, body: request.body, requestHeaders: request.headerDictionary!)
        let responseString = response
        return responseString
    }
    
    func getData(string: String) -> NSData {
        return string.data(using:NSUTF8StringEncoding, allowLossyConversion: false)!
    }
}