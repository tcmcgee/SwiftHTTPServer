import XCTest

class RedirectRouteTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGetStatusCode() {
        let redirectRoute = RedirectRoute()
        
        XCTAssertEqual(redirectRoute.getResponseStatusCode(method: .Redirect), "302")
    }
    
    func testGetHeaders() {
        let redirectRoute = RedirectRoute()
        
        let headers = redirectRoute.getResponseHeaders(uri: "/redirect", method: .Redirect, requestBody: "")
        
        XCTAssert(headers.keys.contains("Location"))
        XCTAssertEqual(headers["Location"], "http://localhost:5000/")
    }
}
