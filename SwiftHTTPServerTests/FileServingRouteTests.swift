import XCTest

class FileServingRouteTests: XCTestCase {
    
    func testGetHeaders() {
        let fileServingRoute = FileServingRoute()
        let expectedHeaders: Dictionary<String,String> = [:]
        let headers = fileServingRoute.getResponseHeaders(uri: "/blah", method: .Get, requestBody: "")
        
        XCTAssertEqual(expectedHeaders, headers)
    }
    
    func testGetStatusCodeAfterPartialRequest() {
        let fileServingRoute = FileServingRoute()
        let requestHeaders: Dictionary<String,String> = ["Range": "bytes=0-1"]
        fileServingRoute.getResponseBody(uri: "/blah", method: .Get, requestHeaders: requestHeaders, requestBody: "")
        
        XCTAssertEqual("206", fileServingRoute.getResponseStatusCode(method: .Get))
    }
    
    func testGetStatusCodeErrorAfterInvalidPartialRequest() {
        let fileServingRoute = FileServingRoute()
        let requestHeaders: Dictionary<String,String> = ["Range": "bytes=30-1"]
        fileServingRoute.getResponseBody(uri: "/blah", method: .Get, requestHeaders: requestHeaders, requestBody: "")
        
        XCTAssertEqual("416", fileServingRoute.getResponseStatusCode(method: .Get))
    }
    
    func testGetStatusCodeWithoutPartialRequest() {
        let fileServingRoute = FileServingRoute()
        fileServingRoute.getResponseBody(uri: "/blah", method: .Get, requestHeaders: Dictionary<String,String>(), requestBody: "")
        
        XCTAssertEqual("200", fileServingRoute.getResponseStatusCode(method: .Get))
    }
    
    func testGetRangeStart() {
        let fileServingRoute = FileServingRoute()
        let range = "bytes=0-1"
        let expectedStartIndex = 0
        
        let startIndex = fileServingRoute.getRangeIndex(range: range, beginning: true)
        
        XCTAssertEqual(expectedStartIndex, startIndex)
    }
    
    func testGetRangeStartNoVal() {
        let fileServingRoute = FileServingRoute()
        let range = "bytes=-1"
        let expectedStartIndex = 0
        
        let startIndex = fileServingRoute.getRangeIndex(range: range, beginning: true)
        
        XCTAssertEqual(expectedStartIndex, startIndex)
    }
    
    func testGetRangeEnd() {
        let fileServingRoute = FileServingRoute()
        let range = "bytes=0-1"
        let expectedendIndex = 1
        
        let endIndex = fileServingRoute.getRangeIndex(range: range, beginning: false)
        
        XCTAssertEqual(expectedendIndex, endIndex)
    }
    
    func testGetRangeEndNoVal() {
        let fileServingRoute = FileServingRoute()
        let range = "bytes=0-"
        let expectedEndIndex = -2
        
        let endIndex = fileServingRoute.getRangeIndex(range: range, beginning: false)
        
        XCTAssertEqual(expectedEndIndex, endIndex)
    }
    
    func testGetRangeStartEndNoVals() {
        let fileServingRoute = FileServingRoute()
        let range = "bytes=-"
        let expectedStartIndex = 0
        let expectedEndIndex = -2
        
        let startIndex = fileServingRoute.getRangeIndex(range: range, beginning: true)
        let endIndex = fileServingRoute.getRangeIndex(range: range, beginning: false)
        
        
        XCTAssertEqual(expectedStartIndex, startIndex)
        XCTAssertEqual(expectedEndIndex, endIndex)
    }
    
    func testGetStatusCodeAfterPatchRequest() {
        let fileServingRoute = FileServingRoute()
        let requestHeaders: Dictionary<String,String> = ["If-Match": "12345"]
        fileServingRoute.getResponseBody(uri: "/blah", method: .Patch, requestHeaders: requestHeaders, requestBody: "")
        
        XCTAssertEqual("204", fileServingRoute.getResponseStatusCode(method: .Patch))
    }
    
    func testGetETagHeaderAfterPatchRequest() {
        let fileServingRoute = FileServingRoute()
        let requestHeaders: Dictionary<String,String> = ["If-Match": "12345"]
        let expectedResponseHeaders: Dictionary<String,String> = ["ETag": "12345"]
        
        fileServingRoute.getResponseBody(uri: "/blah", method: .Patch, requestHeaders: requestHeaders, requestBody: "")
        
        let responseHeaders = fileServingRoute.getResponseHeaders(uri: "/blah", method: .Patch, requestBody: "")
        
        
        XCTAssertEqual(expectedResponseHeaders, responseHeaders)
    }

}