import XCTest

class BasicRouteTests: XCTestCase {
    
    func testBasicRouteInitializedWithAllowedMethods() {
        let route = BasicRoute(allowedMethods: "GET,OPTIONS")
        let expectedMethods = ["GET","OPTIONS"]
        XCTAssertEqual(expectedMethods, route.allowedMethods!)
    }
    
    func testGetAllowedMethods() {
        let route = BasicRoute(allowedMethods: "GET,OPTIONS,POST")
        let expectedMethods = ["GET","OPTIONS","POST"]
        XCTAssertEqual(expectedMethods, route.getAllowedMethods())
    }
    
    func testIsAllowedMethod() {
        let route = BasicRoute(allowedMethods: "GET,OPTIONS,POST")
        
        XCTAssert(route.isAllowedMethod(method: "GET"))
    }
    
    func testGetBody() {
        let route = BasicRoute(allowedMethods: "GET,OPTIONS")
        let expectedResponseBody = ("GET for /testing123")
        
        let responseBody = route.getResponseBody(uri: "/testing123", method: "GET", requestHeaders: Dictionary<String,String>(), requestBody: nil)
        let responseBodyString = NSString(bytes: responseBody,length: responseBody.count, encoding: NSUTF8StringEncoding)
        
        XCTAssertEqual(responseBodyString, expectedResponseBody)
    }
    
    func testGetResponseHeaders() {
        let route = BasicRoute(allowedMethods: "GET,OPTIONS")
        var expectedHeaders = Dictionary<String,String>()
        expectedHeaders["Content-Type"] = "text/html"
        expectedHeaders["Allow"] = "GET,OPTIONS"
        
        let headers = route.getResponseHeaders(uri: "/yolo", method: "OPTIONS", requestBody: nil)
        
        XCTAssertEqual(expectedHeaders, headers)
        
    }
    
    func testGetResponseStatusCode() {
        let route = BasicRoute(allowedMethods: "GET,OPTIONS")
        let expectedResponseCode = "200"
        
        XCTAssertEqual(expectedResponseCode, route.getResponseStatusCode(method: "GET"))
    }
    
    func testGetResponseStatusCodeNotAllowed() {
        let route = BasicRoute(allowedMethods:"GET")
        let expectedResponseCode = "405"
        
        XCTAssertEqual(expectedResponseCode, route.getResponseStatusCode(method: "POST"))
    }
    
    func testGetByteArrayFromString() {
        let route = BasicRoute(allowedMethods: "GET,OPTIONS")
        let string = "aaaa"
        let expectedByteArray: [UInt8] = [97, 97, 97, 97, 0]
        
        XCTAssertEqual(route.getByteArrayFromString(string: string),expectedByteArray)
    }
    
    func testRemoveNullBytesFromByteArray() {
        let route = BasicRoute(allowedMethods: "GET")
        let byteArray: [UInt8] = [0,1,2,0,4]
        
        let expectedResults: [UInt8] = [1,2,4]
        
        XCTAssertEqual(route.removeNullBytes(byteArray: byteArray), expectedResults)
    }

}
