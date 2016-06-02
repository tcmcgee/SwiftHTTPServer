class HTTPResponseGenerator {

    func generateResponse(URI : String?, baseURI: String, method : HTTPMethods, body : String?, requestHeaders: Dictionary<String, String> ) -> [UInt8] {
        let router = Router(uri: baseURI, method: method, body: body)
        router.initializeRouterDict()
        let route = router.getRoute()
        let response = Response()
        
        let bodyString = route.getResponseBody(uri: URI!, method: method, requestHeaders: requestHeaders, requestBody: body)
        response.setBody(body: bodyString)
        
        response.setStatusCode(statusCode: route.getResponseStatusCode(method: method))
        
        let headers = route.getResponseHeaders(uri:baseURI,method: method, requestBody: body)
        for header in headers {
            response.setHeader(header: header.key, value: header.value)
        }
        
        
        return response.GetHTTPResponse()
    }
}