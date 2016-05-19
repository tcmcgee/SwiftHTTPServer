class HTTPResponseGenerator {

    func generateResponse(URI : String?, baseURI: String, method : String, body : String? ) -> [UInt8] {
        let router = Router(uri: baseURI, method: method, body: body)
        router.initializeRouterDict()
        let route = router.getRoute()
        let response = Response()
    
        response.setStatusCode(statusCode: route.getResponseStatusCode(method: method))
        
        let bodyString = route.getResponseBody(uri: URI!, method: method, requestBody: body)
        response.setBody(body: bodyString)
        
        let headers = route.getResponseHeaders(uri:baseURI,method: method, requestBody: body)
        for header in headers {
            response.setHeader(header: header.key, value: header.value)
        }
        
        
        return response.GetHTTPResponse()
    }
}