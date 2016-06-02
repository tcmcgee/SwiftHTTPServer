import XCTest

class RedirectRouteTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGetStatusCode() {
        let redirectRoute = RedirectRoute(allowedMethods: [.Get, .Options, .Redirect])
        
        XCTAssertEqual(redirectRoute.getResponseStatusCode(method: "REDIRECT"), "302")
    }
    
    func testGetHeaders() {
        let redirectRoute = RedirectRoute(allowedMethods: [.Get, .Options, .Redirect])
        
        let headers = redirectRoute.getResponseHeaders(uri: "/redirect", method: "REDIRECT", requestBody: "")
        
        XCTAssert(headers.keys.contains("Location"))
        XCTAssertEqual(headers["Location"], "http://localhost:5000/")
    }
}
