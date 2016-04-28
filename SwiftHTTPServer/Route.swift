import Foundation


protocol Route{

    var allowedMethods: [String]? {get}
    init(allowedMethods: String)
    func getAllowedMethods() -> [String]
    func getResponseHeaders(uri: String, method: String, requestBody: String?) -> Dictionary<String,String> 
    func getResponseBody(uri: String, method: String, requestBody: String?) -> String
    func getResponseStatusCode() -> String
    func isAllowedMethod(method: String) -> Bool
}