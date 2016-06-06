import XCTest

class BasicRouteTests: XCTestCase {
    
    func testBasicRouteInitializedWithAllowedMethods() {
        let route = BasicRoute(allowedMethods: [.Get, .Options])
        let expectedMethods: [HTTPMethods] = [.Get, .Options]
        XCTAssertEqual(expectedMethods, route.allowedMethods)
    }
    
    func testGetAllowedMethods() {
        let route = BasicRoute(allowedMethods: [.Get, .Options, .Post])
        let expectedMethods: [HTTPMethods] = [.Get, .Options, .Post]
        XCTAssertEqual(expectedMethods, route.getAllowedMethods())
    }
    
    func testIsAllowedMethod() {
        let route = BasicRoute(allowedMethods: [.Get, .Options, .Post])
        
        XCTAssert(route.isAllowedMethod(method: .Get))
    }
    
    func testGetBody() {
        let route = BasicRoute(allowedMethods: [.Get, .Options])
        let expectedResponseBody = ("GET for /testing123")
        
        let responseBody = route.getResponseBody(uri: "/testing123", method: .Get, requestHeaders: Dictionary<String,String>(), requestBody: nil)
        let responseBodyString = NSString(bytes: responseBody,length: responseBody.count, encoding: NSUTF8StringEncoding)
        
        XCTAssertEqual(responseBodyString, expectedResponseBody)
    }
    
    func testGetResponseHeaders() {
        let route = BasicRoute(allowedMethods: [.Get, .Options])
        var expectedHeaders = Dictionary<String,String>()
        expectedHeaders["Content-Type"] = "text/html"
        expectedHeaders["Allow"] = "GET,OPTIONS"
        
        let headers = route.getResponseHeaders(uri: "/yolo", method: .Options, requestBody: nil)
        
        XCTAssertEqual(expectedHeaders, headers)
        
    }
    
    func testGetResponseStatusCode() {
        let route = BasicRoute(allowedMethods: [.Get, .Options])
        let expectedResponseCode = "200"
        
        XCTAssertEqual(expectedResponseCode, route.getResponseStatusCode(method: .Get))
    }
    
    func testGetResponseStatusCodeNotAllowed() {
        let route = BasicRoute(allowedMethods:[.Get])
        let expectedResponseCode = "405"
        
        XCTAssertEqual(expectedResponseCode, route.getResponseStatusCode(method: .Post))
    }
    
    func testGetByteArrayFromString() {
        let route = BasicRoute(allowedMethods: [.Get, .Options])
        let string = "aaaa"
        let expectedByteArray: [UInt8] = [97, 97, 97, 97, 0]
        
        XCTAssertEqual(route.getByteArrayFromString(string: string),expectedByteArray)
    }
    
    func testRemoveNullBytesFromByteArray() {
        let route = BasicRoute(allowedMethods: [.Get])
        let byteArray: [UInt8] = [0,1,2,0,4]
        
        let expectedResults: [UInt8] = [1,2,4]
        
        XCTAssertEqual(route.removeNullBytes(byteArray: byteArray), expectedResults)
    }
    
    func testContains() {
        let allowedMethods: [HTTPMethods] = [.Get, .Put, .Head]
        
        let route = BasicRoute(allowedMethods: allowedMethods)
        
        XCTAssertTrue(route.contains(allowedMethods: allowedMethods, method: .Get))
    }
    
    func testJoined() {
        func testContains() {
            let allowedMethods: [HTTPMethods] = [.Get, .Put, .Head]
            
            let route = BasicRoute(allowedMethods: allowedMethods)
            let expectedResults = "GET, PUT, HEAD"
            
            XCTAssertEqual(route.joined(allowedMethods: allowedMethods, separator: ","), expectedResults)
        }
    }

}
