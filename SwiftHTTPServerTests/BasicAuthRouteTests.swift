import XCTest

class BasicAuthRouteTests: XCTestCase {

    func testDecodeBase64() {
        let authRoute = BasicAuthRoute()
        let encodedBase64 = "YWRtaW46aHVudGVyMg=="
        
        let decodedBase64 = authRoute.decodeBase64(base64: encodedBase64)
        
        XCTAssertEqual(decodedBase64, "admin:hunter2")
    }
    
    func testGetAuthorizedWithoutHeader() {
        let authRoute = BasicAuthRoute()
        let requestHeaders = Dictionary<String,String>()
        
        let authorized = authRoute.getAuthorized(requestHeaders: requestHeaders)
        
        XCTAssertFalse(authorized)
    }
    
    func testGetAuthorizedWithCorrectHeader() {
        let authRoute = BasicAuthRoute()
        let requestHeaders: Dictionary<String,String> = ["Authorization":"auth YWRtaW46aHVudGVyMg=="]
        
        let authorized = authRoute.getAuthorized(requestHeaders: requestHeaders)
        
        XCTAssertTrue(authorized)
    }
    
    func testGetAuthorizedWithIncorrectHeader() {
        let authRoute = BasicAuthRoute()
        let requestHeaders: Dictionary<String,String> = ["Authorization":"auth VG9tIE1jR2VlIFJ1bGVz"]
        
        let authorized = authRoute.getAuthorized(requestHeaders: requestHeaders)
        
        XCTAssertFalse(authorized)
    }
    
    func testGetResponseBodyWithOutCredentials() {
        let authRoute = BasicAuthRoute()
        let requestHeaders = Dictionary<String,String>()
        
        let responseBody = authRoute.getResponseBody(uri: "/logs", method: .Get, requestHeaders: requestHeaders, requestBody: "")
        
        XCTAssertEqual([UInt8](), responseBody)
    }
    
    func testGetStatusCodeWithoutCredentials() {
        let authRoute = BasicAuthRoute()
        let requestHeaders = Dictionary<String,String>()
        
        authRoute.getResponseBody(uri: "/logs", method: .Get, requestHeaders: requestHeaders, requestBody: "")
        let statusCode = authRoute.getResponseStatusCode(method: .Get)
        
        XCTAssertEqual("401", statusCode)
    }
    
    func testGetReponseBodyWithIncorrectCredentials() {
        let authRoute = BasicAuthRoute()
        let requestHeaders: Dictionary<String,String> = ["Authorization":"auth VG9tIE1jR2VlIFJ1bGVz"]
        
        let responseBody = authRoute.getResponseBody(uri: "/Logs", method: .Get, requestHeaders: requestHeaders, requestBody: "")
        
        XCTAssertEqual([UInt8](), responseBody)
    }
    
    func testGetReponseBodyWithCorrectCredentials() {
        let authRoute = BasicAuthRoute()
        Configuration.logDirectory = "."
        Logger.log(fileName: "/log.txt",pathToDir: Configuration.logDirectory, string: "GET /method_options HTTP/1.1")
        let requestHeaders: Dictionary<String,String> = ["Authorization":"auth YWRtaW46aHVudGVyMg=="]
        
        let responseBody = authRoute.getResponseBody(uri: "/Logs", method: .Get, requestHeaders: requestHeaders, requestBody: "")
        
        XCTAssertNotEqual([UInt8](), responseBody)
    }
    
    func testGetStatusCodeWithCorrectCredentials() {
        let authRoute = BasicAuthRoute()
        let requestHeaders: Dictionary<String,String> = ["Authorization":"auth YWRtaW46aHVudGVyMg=="]
        
        authRoute.getResponseBody(uri: "/Logs", method: .Get, requestHeaders: requestHeaders, requestBody: "")
        let statusCode = authRoute.getResponseStatusCode(method: .Get)
        XCTAssertEqual("200", statusCode)
    }
    
}
 