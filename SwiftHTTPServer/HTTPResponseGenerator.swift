import Foundation

class HTTPResponseGenerator{
    
    func generateResponse(URI : String?, method : String, bodyData : NSData? ) -> Unmanaged<CFHTTPMessage>{
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
                        let dataString : String = String(data: bodyData!, encoding: NSUTF8StringEncoding)!
                        formData.Write(string: dataString)
                    }
                    else if (method == "DELETE")
                    {
                        formData.Delete()
                        //Remove the data from the text file, calls appropriate method on form
                    }
                    else if (method == "GET")
                    {
                        //Get the data from the form and add it to the body
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
        var allowedMethods = NSMutableSet()
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