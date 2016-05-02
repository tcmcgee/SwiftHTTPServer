import XCTest

class ParameterDecoderTests: XCTestCase {
    
    let URIWithParams = "/parameters?variable_1=Operators%20%3C%2C%20%3E%2C%20%3D%2C%20!%3D%3B%20%2B%2C%20-%2C%20*%2C%20%26%2C%20%40%2C%20%23%2C%20%24%2C%20%5B%2C%20%5D%3A%20%22is%20that%20all%22%3F&variable_2=stuff"
    
    var decoder : ParameterDecoder?

    override func setUp() {
        super.setUp()
        decoder = ParameterDecoder(uri: URIWithParams)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testSplit() {
        let expectedResults = ["Hello", "Friends"]
        
        let splitArray = decoder!.split(string: "Hello Friends", separator: " ")
        
        XCTAssertEqual(expectedResults, splitArray)
    }
    
    func testDoesntSplit() {
        let expectedResults = ["Hello"]
        
        let splitArray = decoder!.split(string: "Hello", separator: " ")
        
        XCTAssertEqual(expectedResults, splitArray)
    }

    func testHasParameters() {
        
        XCTAssert(decoder!.hasParameters())
    }
    
    func testDoesNotHaveParameters() {
        decoder = ParameterDecoder(uri: "/")
        
        XCTAssertFalse(decoder!.hasParameters())
    }
    
    func testGetParameters() {
        let expectedParams = "variable_1=Operators%20%3C%2C%20%3E%2C%20%3D%2C%20!%3D%3B%20%2B%2C%20-%2C%20*%2C%20%26%2C%20%40%2C%20%23%2C%20%24%2C%20%5B%2C%20%5D%3A%20%22is%20that%20all%22%3F&variable_2=stuff"
        let params = decoder!.getParameters()
        
        XCTAssertEqual(expectedParams, params)
    }
    
    func testGetNoParams() {
        decoder = ParameterDecoder(uri: "/")
        let params = decoder!.getParameters()
        
        XCTAssertEqual("", params)
    }
    
    func testGetBaseURI() {
        let expectedURI = "/parameters"
        let baseURI = decoder!.getBaseURI()
        
        XCTAssertEqual(expectedURI, baseURI)
    }
    func testGetInitialReplacements() {
        let originalString = "===&"
        let expectedResults = " =  =  =  "
        
        XCTAssertEqual(decoder?.initialReplacements(string: originalString), expectedResults)
        
    }
    
    func testGetCharFromURLEncoding() {
        let decodedChar = decoder!.getCharFromURLEncoding(replacedString: "%21")
        
        XCTAssertEqual(decodedChar, "!")
    }
    
    func testGetDecodedParameters() {
        let expectedResults = "variable_1 = Operators <, >, =, !=; +, -, *, &, @, #, $, [, ]: \"is that all\"? variable_2 = stuff"
        
        let decodedParameters = decoder!.getDecodedParameters()
        
        XCTAssertEqual(expectedResults, decodedParameters)
    }
    
    
    
}
