protocol Route {

    var allowedMethods: [String]? {get}
    init(allowedMethods: String)
    func getAllowedMethods() -> [String]
    func getResponseHeaders(uri: String, method: String, requestBody: String?) -> Dictionary<String,String>
    func getResponseBody(uri: String, method: String, requestHeaders: Dictionary<String,String>, requestBody: String?) -> [UInt8]
    func getResponseStatusCode(method: String) -> String
    func isAllowedMethod(method: String) -> Bool
}