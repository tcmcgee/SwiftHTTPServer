import XCTest

class HTTPResponseHandlerTests: XCTestCase {
    let responseHandler = HTTPResponseHandler()
    
    let HTTPRequest = Request(requestString: "GET / HTTP/1.1\r\nHost: localhost:5000\r\nConnection: keep-alive\r\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\r\n\r\n")
    
    
    func testGetResponse(){
        let expectedResponse = "HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=UTF-8\r\n\r\nGET for /"
        let response = responseHandler.getResponse(request: HTTPRequest)
        
        XCTAssertEqual(expectedResponse, response)
    }
    
    func testGetData() {
        let data = responseHandler.getData(string: "H")
        let expectedData = "H".data(using: NSUTF8StringEncoding)
        
        XCTAssertEqual(expectedData, data)
    }
}
