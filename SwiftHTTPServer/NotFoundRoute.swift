import Foundation
class NotFoundRoute: BasicRoute {
    
    override func getResponseBody(uri: String, method: String, requestBody: String?) -> String {
        return "404 - Not Found"
    }
    
    override func getResponseStatusCode(method: String) -> String {
        return "404"
    }
    
}