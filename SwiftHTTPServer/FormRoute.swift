class FormRoute: BasicRoute {
    
    override func getResponseBody(uri: String, method: String, requestBody: String?) -> String {
        let formData = FormData()
        var formBody = ""
        if (isAllowedMethod(method: method)) {
            if ((method == "POST" || method == "PUT" || method == "DELETE")) {
                formData.formAction(method: method, body: requestBody!)
                formBody = super.getResponseBody(uri: uri, method: method, requestBody: requestBody)
            } else if (method == "GET") {
                formBody = formData.Read()
            }
        } else {
            formBody = "405 - Method Not Allowed"
        }
        return formBody
    }
}
