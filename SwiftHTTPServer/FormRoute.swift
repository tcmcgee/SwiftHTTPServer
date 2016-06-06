class FormRoute: BasicRoute {
    
    override func getResponseBody(uri: String, method: String, requestHeaders: Dictionary<String,String>, requestBody: String?) -> [UInt8] {
        let formData = FileOperations(file: "/form.txt", pathToDir: ".")
        var formBody = [UInt8]()
        if (isAllowedMethod(method: method)) {
            if ((method == "POST" || method == "PUT" || method == "DELETE")) {
                formData.formAction(method: method, body: requestBody!)
            } else if (method == "GET") {
                formBody = formData.read()
            }
        } else {
            formBody = getByteArrayFromString(string: "405 - Method Not Allowed")
        }
        return removeNullBytes(byteArray: formBody)
    }
}
