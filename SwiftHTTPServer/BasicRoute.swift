
import Foundation

class BasicRoute: Route {
    
    var allowedMethods: [String]?
    required init(allowedMethods: String) {
        self.allowedMethods = allowedMethods.components(separatedBy: ",")
    }
    
    func getAllowedMethods() -> [String]{
        return allowedMethods!
    }
    
    func isAllowedMethod(method: String) -> Bool {
        return getAllowedMethods().contains(method)
    }
    
    func getResponseBody(uri: String, method: String, requestBody: String?) -> String {
        return "\(method) for \(uri)"
    }
    
    func getResponseHeaders(uri: String, method: String, requestBody: String?) -> Dictionary<String,String> {
        var headers : Dictionary<String,String> = Dictionary<String,String>()

        headers["Content-Type"] = "text/html; charset=UTF-8"
        if (method == "OPTIONS") {
            headers["Allow"] = allowedMethods!.joined(separator: ",")
        }
        
        return headers
    }
    
    func getResponseStatusCode() -> String {
        return "200"
    }
    
}