import Foundation

class Router{
    var uri: String?
    let URIs = NSMutableSet(objects: "/method_options", "/method_options2", "/form", "/", "/parameters")
    
    
    init(uri: String) {
        self.uri = uri
    }
    func addURI(uri: String) {
        URIs.add(uri)
    }
    
    func removeURI(uri: String) {
        URIs.remove(uri)
    }
    
    func isAllowedURI() -> Bool {
        return URIs.contains(uri!)
    }
    

    func isAllowedMethod(method: String) -> Bool {
        
        return getAllowedMethods().contains(method)
    }
    
    func getAllowedMethodsString() -> String {
        let optionsArray : NSArray = ((getAllowedMethods()).allObjects)
        let allowedMethodString = optionsArray.componentsJoined(by: ",")
        return allowedMethodString
    }
    
    func getAllowedMethods() -> NSSet {
        let allowedMethods = NSMutableSet(objects: "GET", "OPTIONS", "HEAD", "POST", "PUT", "DELETE")
        if (uri == "/method_options2") {
            allowedMethods.remove("HEAD")
            allowedMethods.remove("POST")
            allowedMethods.remove("PUT")
            allowedMethods.remove("DELETE")
        }
        
        return allowedMethods
    }

    
}
