import XCTest

class FileServingRouteTests: XCTestCase {
    
    func testGetHeaders() {
        let fileServingRoute = FileServingRoute(allowedMethods: "GET")
        let expectedHeaders: Dictionary<String,String> = [:]
        let headers = fileServingRoute.getResponseHeaders(uri: "/blah", method: "GET", requestBody: "")
        
        XCTAssertEqual(expectedHeaders, headers)
    }
    
    func testGetStatusCodeAfterPartialRequest() {
        let fileServingRoute = FileServingRoute(allowedMethods: "GET")
        let requestHeaders: Dictionary<String,String> = ["Range": "bytes=0-1"]
        fileServingRoute.getResponseBody(uri: "/blah", method: "GET", requestHeaders: requestHeaders, requestBody: "")
        
        XCTAssertEqual("206", fileServingRoute.getResponseStatusCode(method: "GET"))
    }
    
    func testGetStatusCodeErrorAfterInvalidPartialRequest() {
        let fileServingRoute = FileServingRoute(allowedMethods: "GET")
        let requestHeaders: Dictionary<String,String> = ["Range": "bytes=30-1"]
        fileServingRoute.getResponseBody(uri: "/blah", method: "GET", requestHeaders: requestHeaders, requestBody: "")
        
        XCTAssertEqual("416", fileServingRoute.getResponseStatusCode(method: "GET"))
    }
    
    func testGetStatusCodeWithoutPartialRequest() {
        let fileServingRoute = FileServingRoute(allowedMethods: "GET")
        fileServingRoute.getResponseBody(uri: "/blah", method: "GET", requestHeaders: Dictionary<String,String>(), requestBody: "")
        
        XCTAssertEqual("200", fileServingRoute.getResponseStatusCode(method: "GET"))
    }
    
    func testGetRangeStart() {
        let fileServingRoute = FileServingRoute(allowedMethods: "GET")
        let range = "bytes=0-1"
        let expectedStartIndex = 0
        
        let startIndex = fileServingRoute.getRangeIndex(range: range, beginning: true)
        
        XCTAssertEqual(expectedStartIndex, startIndex)
    }
    
    func testGetRangeStartNoVal() {
        let fileServingRoute = FileServingRoute(allowedMethods: "GET")
        let range = "bytes=-1"
        let expectedStartIndex = 0
        
        let startIndex = fileServingRoute.getRangeIndex(range: range, beginning: true)
        
        XCTAssertEqual(expectedStartIndex, startIndex)
    }
    
    func testGetRangeEnd() {
        let fileServingRoute = FileServingRoute(allowedMethods: "GET")
        let range = "bytes=0-1"
        let expectedendIndex = 1
        
        let endIndex = fileServingRoute.getRangeIndex(range: range, beginning: false)
        
        XCTAssertEqual(expectedendIndex, endIndex)
    }
    
    func testGetRangeEndNoVal() {
        let fileServingRoute = FileServingRoute(allowedMethods: "GET")
        let range = "bytes=0-"
        let expectedEndIndex = -2
        
        let endIndex = fileServingRoute.getRangeIndex(range: range, beginning: false)
        
        XCTAssertEqual(expectedEndIndex, endIndex)
    }
    
    func testGetRangeStartEndNoVals() {
        let fileServingRoute = FileServingRoute(allowedMethods: "GET")
        let range = "bytes=-"
        let expectedStartIndex = 0
        let expectedEndIndex = -2
        
        let startIndex = fileServingRoute.getRangeIndex(range: range, beginning: true)
        let endIndex = fileServingRoute.getRangeIndex(range: range, beginning: false)
        
        
        XCTAssertEqual(expectedStartIndex, startIndex)
        XCTAssertEqual(expectedEndIndex, endIndex)
    }
    
    func testGetStatusCodeAfterPatchRequest() {
        let fileServingRoute = FileServingRoute(allowedMethods: "GET,PATCH")
        let requestHeaders: Dictionary<String,String> = ["If-Match": "12345"]
        fileServingRoute.getResponseBody(uri: "/blah", method: "PATCH", requestHeaders: requestHeaders, requestBody: "")
        
        XCTAssertEqual("204", fileServingRoute.getResponseStatusCode(method: "PATCH"))
    }
    
    func testGetETagHeaderAfterPatchRequest() {
        let fileServingRoute = FileServingRoute(allowedMethods: "GET,PATCH")
        let requestHeaders: Dictionary<String,String> = ["If-Match": "12345"]
        let expectedResponseHeaders: Dictionary<String,String> = ["ETag": "12345"]
        
        fileServingRoute.getResponseBody(uri: "/blah", method: "PATCH", requestHeaders: requestHeaders, requestBody: "")
        
        let responseHeaders = fileServingRoute.getResponseHeaders(uri: "/blah", method: "PATCH", requestBody: "")
        
        
        XCTAssertEqual(expectedResponseHeaders, responseHeaders)
    }

}