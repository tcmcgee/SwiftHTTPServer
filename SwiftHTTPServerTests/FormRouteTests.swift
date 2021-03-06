import XCTest

class FormRouteTests: XCTestCase {
    let fileManager = NSFileManager()
    let file = "testRoute.txt"
    var formRoute = FormRoute()
    
    override func tearDown() {
        super.tearDown()
        formRoute.getResponseBody(uri: "/form", method: .Delete, requestHeaders: Dictionary<String,String>(), requestBody: "")
    }
    
    func testGetResponseBody() {
        formRoute.getResponseBody(uri: "/form", method: .Post, requestHeaders: Dictionary<String,String>(), requestBody:"Howdy")
        
        let fileContents = formRoute.getResponseBody(uri: "/form", method: .Get , requestHeaders: Dictionary<String,String>(), requestBody:"")
        let fileContentsString = NSString(bytes: fileContents,length: fileContents.count, encoding: NSUTF8StringEncoding)

        XCTAssertEqual("Howdy",fileContentsString)
    }
    
}
