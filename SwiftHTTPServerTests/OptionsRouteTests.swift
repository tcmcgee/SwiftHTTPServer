import XCTest

class OptionsRouteTests: XCTestCase {
    
    func testGetResponseHeaders() {
        let optionsRoute = OptionsRoute(allowedMethods: [.Get, .Put, .Options])
        
        let allowsHeader = optionsRoute.getResponseHeaders(uri: "/test", method: .Options, requestBody: "")["Allow"]
        
        XCTAssertEqual(allowsHeader, "GET,PUT,OPTIONS")
    }
    
}