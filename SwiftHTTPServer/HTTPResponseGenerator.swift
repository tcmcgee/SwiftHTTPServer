import Foundation

class HTTPResponseGenerator{
    
    func generateResponse(URI : String?, method : String, body : String? ) -> Unmanaged<CFHTTPMessage>{
        var response = CFHTTPMessageCreateResponse(kCFAllocatorDefault, 404, nil, kCFHTTPVersion1_1)
        if (isValidURI(URI: URI!)){
            var bodyString = ("\(method) for \(URI!)\n")
            if (getAllowedMethods(URI: URI!).contains(method)){
                response = CFHTTPMessageCreateResponse(kCFAllocatorDefault, 200, nil, kCFHTTPVersion1_1)
                CFHTTPMessageSetHeaderFieldValue(response.takeUnretainedValue() , "Content-Type", "text/html")
                if (method == "OPTIONS")
                {
                    let optionsArray : NSArray = ((getAllowedMethods(URI: URI!)).allObjects)
                    let allowedMethodString = optionsArray.componentsJoined(by: ",")
                    CFHTTPMessageSetHeaderFieldValue(response.takeUnretainedValue(), "Allow", allowedMethodString)
                }
                if (URI! == "/form") {
                    let formData = FormData()
                    if (method == "POST" || method == "PUT") {
                        formData.Write(string: body!)
                    }
                    else if (method == "DELETE")
                    {
                        formData.Delete()
                    }
                    else if (method == "GET")
                    {
                        let formBody = formData.Read()
                        CFHTTPMessageSetBody(response.takeUnretainedValue(), formBody.data(using: NSUTF8StringEncoding)!)
                    }
                }
                else{
                    //Placeholder body with just the request and URI
                    CFHTTPMessageSetBody(response.takeUnretainedValue(), bodyString.data(using: NSUTF8StringEncoding)!)
                }
            } else {
                bodyString = "501 - Not Implemented"
                CFHTTPMessageSetBody(response.takeUnretainedValue(), bodyString.data(using: NSUTF8StringEncoding)!)
            }
        }
        
        return response
    }
    
    func isValidURI(URI : String) -> Bool{
        return true
    }
    
    func getAllowedMethods(URI: String) -> NSSet{
        let allowedMethods = NSMutableSet()
        allowedMethods.add("GET")
        allowedMethods.add("OPTIONS")
        if (URI != "/method_options2") {
            allowedMethods.add("HEAD")
            allowedMethods.add("POST")
            allowedMethods.add("PUT")
            allowedMethods.add("DELETE")
        }

        return allowedMethods
    }
}