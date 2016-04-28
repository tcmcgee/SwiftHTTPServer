import Foundation

class HTTPResponseGenerator {

    func generateResponse(URI : String?, baseURI: String, method : String, body : String? ) -> String {
        let router = Router(uri: baseURI, method: method, body: body)
        let response = Response()
        let route = router.getRoute()
        let bodyString = route!.getResponseBody(uri: URI!, method: method, requestBody: body)
        response.setBody(body: bodyString)
        if (route!.isAllowedMethod(method: method)) {
            response.setStatusCode(statusCode: route!.getResponseStatusCode())
            let headers = route!.getResponseHeaders(uri:baseURI,method: method, requestBody: body)
            for header in headers {
                response.setHeader(header: header.key, value: header.value)
            }
            if (uriIsParametersWithParams(URI: URI)) {
                let decoder = ParameterDecoder(uri: URI!)
                response.setBody(body: decoder.getDecodedParameters())
            }
        }
    return response.GetHTTPResponse()
    }
    
    
    func uriIsParametersWithParams(URI: String?) -> Bool {
        var parameterRegExp: NSRegularExpression?
        do{
            parameterRegExp = try NSRegularExpression(pattern: "parameters?.*", options: .caseInsensitive)
        } catch{ }
        return (parameterRegExp!.firstMatch(in: URI!, options: NSMatchingOptions.reportCompletion, range: NSRange(location: 0,length: URI!.characters.count)) != nil)
    }
}