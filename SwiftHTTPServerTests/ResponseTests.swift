import XCTest

class ResponseTests: XCTestCase {

    var response : Response?
    
    override func setUp() {
        super.setUp()
        response = Response()
    }
    
    func testSetResponse() {
        let myResponse: String = "Pickle juice\r\n" +
                                "Taco Party"
        response!.setResponse(response: myResponse)
        
        XCTAssertEqual(myResponse, response!.response)
    }
    
    
    func testGetResponse() {
        let myResponse: String = "HTTP1.1 GET OK\r\n" +
                                "Content-Length: 123"
        
        response!.response = myResponse
        
        XCTAssertEqual(response!.getResponse(), myResponse)
        
    }
    
    func testSetStatusCode() {
        let statusCode = "200"
        
        response!.setStatusCode(statusCode: statusCode)
        
        XCTAssertEqual(statusCode, response!.statusCode)
    }
    
    func testGetStatusCode() {
        let statusCode = "200"
    
        response!.statusCode = statusCode
        
        XCTAssertEqual(statusCode, response!.getStatusCode())
    }
    
    func testAddHeader() {
        response!.setHeader(header: "Content-Length", value: "15")
        
        XCTAssertEqual(response!.headers["Content-Length"], "15")
    }
    
    func testGetHeader() {
        response!.headers["Allow"] = "GET, POST"
        
        XCTAssertEqual(response!.getHeader(header: "Allow"), "GET, POST")
    }
    
    func testGetHeaderThatsNotDefinited() {
        
        XCTAssertEqual(response!.getHeader(header: "DoesNotExist"), "DNE")
    }
    
    func testGetHTTPVersion() {
        response!.HTTPVersion = "HTTP/1.1"
        
        XCTAssertEqual(response!.getHTTPVersion(), "HTTP/1.1")
    }
    
    func testSetHTTPVersion() {
        let HTTPVersion = "HTTP/1.0"
        
        response!.setHTTPVersion(httpVersion: HTTPVersion)
        
        XCTAssertEqual(HTTPVersion, response!.HTTPVersion)
    }
    
    func testGetBody() {
        let body = "Taco"
        
        response!.body = body
        
        XCTAssertEqual(body, response!.getBody())
    }
    
    func testSetBody() {
        
        let body = "Taco Party"
        
        response!.setBody(body: body)
        
        XCTAssertEqual(body, response!.body)
        
    }
    func testGetStatusLine() {
        response!.statusCode = "200"
        response!.HTTPVersion = "HTTP/1.1"
        
        let statusLine = response!.getStatusLine()
        
        XCTAssertEqual(statusLine, "HTTP/1.1 200 OK\r\n")
        
    }
    
    func testGetHeadersString() {
        response!.headers["Host"] = "localhost:5000"
        response!.headers["Allow"] = "GET"
        response!.headers["Content-Length"] = "0"
        
        let headersString = response!.getHeadersString()
        
        XCTAssertEqual(headersString, "Allow: GET\r\nContent-Length: 0\r\nHost: localhost:5000\r\n\r\n")
    }
    
    func testGetHTTPResponse() {
        response!.statusCode = "200"
        response!.HTTPVersion = "HTTP/1.1"
        response!.headers["Host"] = "localhost:5000"
        response!.headers["Allow"] = "GET"
        response!.headers["Content-Length"] = "0"
        response!.body = "TACO"
        
        let responseString = response!.GetHTTPResponse()
        
        XCTAssertEqual(responseString, "HTTP/1.1 200 OK\r\nAllow: GET\r\nContent-Length: 0\r\nHost: localhost:5000\r\n\r\nTACO")
        
    }
    
}
