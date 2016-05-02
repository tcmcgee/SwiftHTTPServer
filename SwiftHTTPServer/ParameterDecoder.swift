import Foundation

class ParameterDecoder {
    var uri = "/"
    
    init(uri: String) {
        self.uri = uri
    }
    
    func hasParameters() -> Bool {
        let splitURI = split(string: uri, separator: "?")
        return (splitURI.count > 1)
    }
    
    func getBaseURI() -> String {
        let splitURI = split(string: uri, separator: "?")
        return splitURI[0]
    }
    
    func getParameters() -> String {
        let splitURI = split(string: uri, separator: "?")
        var params = ""
        if (splitURI.count > 1){
            params = splitURI[1]
        }
        return params
    }
    
    func initialReplacements(string: String) -> NSString {
        var params = string
        params = params.replacingOccurrences(of: "=", with: " = ")
        params = params.replacingOccurrences(of: "&", with: " ")
        return params
    }
    
    func getDecodedParameters() -> String {
        var params = initialReplacements(string:(getParameters()))
        var regexp: NSRegularExpression?
        do {
            regexp = try NSRegularExpression(pattern: "%..", options: .caseInsensitive)
        } catch { }
        while let match = regexp?.firstMatch(in: params as String, options: NSMatchingOptions.reportCompletion,
                                             range: NSRange(location: 0,length: (params as String).characters.count)) {
            let stringToReplace = params.substring(with: match.range)
            params = params.replacingCharacters(in: match.range, with: getCharFromURLEncoding(replacedString: stringToReplace))
        }
        return params as String
    }
    
    func getCharFromURLEncoding(replacedString: String) -> String {
        var myString = replacedString
        myString.remove(at:myString.startIndex)
        let value = UInt8(strtoul(myString, nil, 16))
        var result = ""
        result.append(Character(UnicodeScalar(value)))
        return result
    }
    
    func split(string: String, separator: String) -> Array<String> {
        return string.components(separatedBy: separator)
    }
}