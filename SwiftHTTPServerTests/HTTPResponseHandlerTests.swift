import XCTest
import Foundation

class HTTPResponseHandlerTests: XCTestCase {
    let responseHandler = HTTPResponseHandler()
    
    let HTTPRequest = Request(requestString: "GET /method_options HTTP/1.1\r\nHost: localhost:5000\r\nConnection: keep-alive\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\r\n\r\n")
    
    
    func testGetResponse(){
        let expectedResponse = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\nGET for /method_options"
        let response = responseHandler.getResponse(request: HTTPRequest)
        let responseString = NSString(bytes: response,length: response.count, encoding: NSUTF8StringEncoding)
        
        XCTAssertEqual(expectedResponse, responseString)
    }
    
    func testGetData() {
        let data = responseHandler.getData(string: "H")
        let expectedData = "H".data(using: NSUTF8StringEncoding)
        
        XCTAssertEqual(expectedData, data)
    }
}
