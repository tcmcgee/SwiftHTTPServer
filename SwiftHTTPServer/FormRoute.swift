class FormRoute: BasicRoute {
    
    override func getResponseBody(uri: String, method: HTTPMethods, requestHeaders: Dictionary<String, String>, requestBody: String?) -> [UInt8] {
        let formData = FileOperations(file: "/form.txt", pathToDir: ".")
        var formBody = [UInt8]()
        if ((method == .Post || method == .Put || method == .Delete)) {
            formData.formAction(method: method, body: requestBody!)
        } else if (method == .Get) {
            formBody = formData.read()
        }
        return removeNullBytes(byteArray: formBody)
    }
}
