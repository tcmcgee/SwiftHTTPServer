import XCTest

class NotFoundRouteTests: XCTestCase {

    func testGetBody() {
        let route = NotFoundRoute()
        let expectedResponseBody = ("404 - Not Found")
        
        let responseBody = route.getResponseBody(uri: "/testing123", method: .Get, requestHeaders: Dictionary<String,String>(), requestBody: nil)
        let responseString = NSString(bytes: responseBody,length: responseBody.count, encoding: NSUTF8StringEncoding)
        print("\(expectedResponseBody) \(responseString)")
        XCTAssertEqual(expectedResponseBody, responseString!)
    }
    
    func testGetResponseStatusCode() {
        let route = NotFoundRoute()
        let expectedResponseCode = "404"
        
        XCTAssertEqual(expectedResponseCode, route.getResponseStatusCode(method: .Get))
    }

}