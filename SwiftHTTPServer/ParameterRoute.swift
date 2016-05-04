class ParameterRoute: BasicRoute {
    override func getResponseBody(uri: String, method: String, requestBody: String?) -> String {
        let parameterDecoder = ParameterDecoder(uri: uri)
        
        return parameterDecoder.getDecodedParameters()
    }
}
