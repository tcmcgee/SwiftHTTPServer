class HTTPResponseGenerator {

    func generateResponse(request: Request) -> [UInt8] {
        let router = Router(request: request)
        let route = router.getRoute()
        let response = Response()
        
        let bodyString = route.getResponseBody(uri: request.URI!, method: request.method, requestHeaders: request.headerDictionary!, requestBody: request.body)
        response.setBody(body: bodyString)
        
        response.setStatusCode(statusCode: route.getResponseStatusCode(method: request.method))
        
        let headers = route.getResponseHeaders(uri:request.baseURI! ,method: request.method, requestBody: request.body)
        for header in headers {
            response.setHeader(header: header.key, value: header.value)
        }
        
        let responseString = response.GetHTTPResponse()
        return responseString
    }
}