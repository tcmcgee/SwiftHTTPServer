import XCTest

class FileServingRouteTests: XCTestCase {
    
    func testGetHeaders() {
        let fileServingRoute = FileServingRoute(allowedMethods: "GET")
        let expectedHeaders: Dictionary<String,String> = [:]
        let headers = fileServingRoute.getResponseHeaders(uri: "/blah", method: "GET", requestBody: "")
        
        XCTAssertEqual(expectedHeaders, headers)
    }

}