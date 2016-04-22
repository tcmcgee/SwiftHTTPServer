import Foundation

class HTTPResponseGenerator {
    
    func generateResponse(URI : String?, method : String, body : String? ) -> String {
        let response = Response()
        if (isValidURI(URI: URI!)) {
            var bodyString = ("\(method) for \(URI!)\n")
            if (getAllowedMethods(URI: URI!).contains(method)) {
                response.setStatusCode(statusCode: "200")
                response.setHeader(header: "Content-Type", value: "text/html")
                if (method == "OPTIONS")
                {
                    let optionsArray : NSArray = ((getAllowedMethods(URI: URI!)).allObjects)
                    let allowedMethodString = optionsArray.componentsJoined(by: ",")
                    response.setHeader(header: "Allow", value: allowedMethodString)
                }
                if (URI! == "/form") {
                    let formData = FormData()
                    if (method == "POST" || method == "PUT") {
                        formData.Write(string: body!)
                    }
                    else if (method == "DELETE") {
                        formData.Delete()
                    }
                    else if (method == "GET") {
                        let formBody = formData.Read()
                        response.setBody(body:formBody)
                    }
                }
                else {
                    //Placeholder body with just the request and URI
                    response.setBody(body: bodyString)
                }
            } else {
                bodyString = "501 - Not Implemented"
                response.setBody(body: bodyString)
            }
        }
        
        return response.GetHTTPResponse()
    }
    
    func isValidURI(URI : String) -> Bool {
        return true
    }
    
    func getAllowedMethods(URI: String) -> NSSet {
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