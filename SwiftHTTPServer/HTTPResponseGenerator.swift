import Foundation

class HTTPResponseGenerator {

    func generateResponse(URI : String?, baseURI: String, method : String, body : String? ) -> String {
        let router = Router(uri: baseURI, method: method, body: body)
        let route = router.getRoute()
        let response = Response()
    
        response.setStatusCode(statusCode: route!.getResponseStatusCode(method: method))
        
        let headers = route!.getResponseHeaders(uri:baseURI,method: method, requestBody: body)
        for header in headers {
            response.setHeader(header: header.key, value: header.value)
        }
        
        let bodyString = route!.getResponseBody(uri: URI!, method: method, requestBody: body)
        response.setBody(body: bodyString)
        
        return response.GetHTTPResponse()
    }
}