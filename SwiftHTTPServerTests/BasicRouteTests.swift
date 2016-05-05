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
        
        let responseBody = route.getResponseBody(uri: "/testing123", method: "GET", requestBody: nil)
        
        XCTAssertEqual(expectedResponseBody, responseBody)
    }
    
    func testGetResponseHeaders() {
        let route = BasicRoute(allowedMethods: "GET,OPTIONS")
        var expectedHeaders = Dictionary<String,String>()
        
        expectedHeaders["Allow"] = "GET,OPTIONS"
        expectedHeaders["Content-Type"] = "text/html; charset=UTF-8"
        
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

}
