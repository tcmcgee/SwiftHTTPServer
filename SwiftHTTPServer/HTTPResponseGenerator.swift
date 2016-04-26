import Foundation

class HTTPResponseGenerator {

    func generateResponse(URI : String?, method : String, body : String? ) -> String {
        let router = Router(uri: URI!)
        let response = Response()
        if (router.isAllowedURI()) {
            var bodyString = ("\(method) for \(URI!)\n")
            response.setBody(body: bodyString)
            if (router.isAllowedMethod(method: method)) {
                response.setStatusCode(statusCode: "200")
                response.setHeader(header: "Content-Type", value: "text/html")
                if (method == "OPTIONS") {
                    response.setHeader(header: "Allow", value: router.getAllowedMethodsString())
                }
                if (URI! == "/form") {
                    let formData = FormData()
                    if (method == "POST" || method == "PUT" || method == "DELETE") {
                        formData.formAction(method: method, body: body!)
                    } else if (method == "GET") {
                        let formBody = formData.Read()
                        response.setBody(body:formBody)
                    }
                }
            } else {
                response.setStatusCode(statusCode: "501")
                bodyString = "501 - Not Implemented"
                response.setBody(body: bodyString)
            }
        }
        else {
            response.setStatusCode(statusCode: "404")
            response.setBody(body: "404 - Not Found")
        }
        return response.GetHTTPResponse()
    }
}