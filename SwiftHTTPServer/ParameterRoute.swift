class ParameterRoute: BasicRoute {
    override func getResponseBody(uri: String, method: HTTPMethods, requestHeaders: Dictionary<String,String>, requestBody: String?) -> [UInt8] {
        let parameterDecoder = ParameterDecoder(uri: uri)
        
        return removeNullBytes(byteArray: getByteArrayFromString(string: parameterDecoder.getDecodedParameters()))
    }
}
