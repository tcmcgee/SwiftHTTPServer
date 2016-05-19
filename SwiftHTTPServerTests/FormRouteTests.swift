import XCTest

class FormRouteTests: XCTestCase {
    let fileManager = NSFileManager()
    let file = "testRoute.txt"
    var formRoute = FormRoute(allowedMethods: "GET,OPTIONS,POST,PUT,DELETE")
    
    override func tearDown() {
        super.tearDown()
        formRoute.getResponseBody(uri: "/form", method: "DELETE", requestHeaders: Dictionary<String,String>(), requestBody: "")
    }
    
    func testGetResponseBody() {
        formRoute.getResponseBody(uri: "/form", method: "POST", requestHeaders: Dictionary<String,String>(), requestBody:"Howdy")
        
        let fileContents = formRoute.getResponseBody(uri: "/form", method: "GET", requestHeaders: Dictionary<String,String>(), requestBody:"")
        let fileContentsString = NSString(bytes: fileContents,length: fileContents.count, encoding: NSUTF8StringEncoding)

        XCTAssertEqual("Howdy",fileContentsString)
    }
    
    func testGetResponseBodyMethodNotAllowed() {
        formRoute = FormRoute(allowedMethods: "GET,OPTIONS,POST,PUT")
        
        let expectedResults = "405 - Method Not Allowed"
        
        let fileContents = formRoute.getResponseBody(uri: "/form", method: "DELETE", requestHeaders: Dictionary<String,String>(), requestBody: "")
        let fileContentsString = NSString(bytes: fileContents,length: fileContents.count, encoding: NSUTF8StringEncoding)
        
        XCTAssertEqual(expectedResults, fileContentsString)
    }
    
}
