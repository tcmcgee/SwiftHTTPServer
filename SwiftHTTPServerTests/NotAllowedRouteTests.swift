import XCTest

class NotAllowedRouteTests: XCTestCase {
    
    func testGetBody() {
        let route = NotAllowedRoute(allowedMethods: [.Get])
        let expectedResponseBody = ("405 - Method Not Allowed")
        
        let responseBody = route.getResponseBody(uri: "/testing123", method: .Get, requestHeaders: Dictionary<String,String>(), requestBody: nil)
        let responseString = NSString(bytes: responseBody,length: responseBody.count, encoding: NSUTF8StringEncoding)
        print("\(expectedResponseBody) \(responseString)")
        XCTAssertEqual(expectedResponseBody, responseString!)
    }
    
    func testGetResponseStatusCode() {
        let route = NotAllowedRoute(allowedMethods: [.Get, .Options])
        let expectedResponseCode = "405"
        
        XCTAssertEqual(expectedResponseCode, route.getResponseStatusCode(method: .Get))
    }
    
}