import XCTest

class RouterTests: XCTestCase {
    
    
    override func setUp() {
        super.setUp()
        
        Configuration.enableLogging = false
        Configuration.routes = Routes()
        Configuration.routes.add(uri: "/", method: .Get, route: DirectoryListRoute())
    }

    override func tearDown() {
        super.tearDown()
        
        Configuration.enableLogging = true
    }
    
    func testReturnsTheExpectedRoute() {
        Configuration.enableLogging = false
        let request = Request(requestString: "GET / HTTP/1.1\r\nHost: localhost:5000\r\nUser-Agent: curl/7.43.0\r\nAccept: */*\r\nContent-Length: 0\r\nContent-Type: application/x-www-form-urlencoded\r\n\r\n")
        
        let router = Router(request: request)
        
        
        XCTAssertEqual(router.getRoute().getResponseStatusCode(method: .Get), "200")
        XCTAssertNotNil(router.getRoute() as? DirectoryListRoute)
    }

    func testReturns404WhenNotFound() {
        Configuration.enableLogging = false
        let request = Request(requestString: "GET / HTTP/1.1\r\nHost: localhost:5000\r\nUser-Agent: curl/7.43.0\r\nAccept: */*\r\nContent-Length: 0\r\nContent-Type: application/x-www-form-urlencoded\r\n\r\n")
        request.method = .Get
        request.baseURI = "/YOLO"
        
        let router = Router(request: request)
        
        
        XCTAssertEqual(router.getRoute().getResponseStatusCode(method: .Get), "404")
    }
    
    func testReturns405WhenMethodNotFound() {
        Configuration.enableLogging = false
        let request = Request(requestString: "TAKA / HTTP/1.1\r\nHost: localhost:5000\r\nUser-Agent: curl/7.43.0\r\nAccept: */*\r\nContent-Length: 0\r\nContent-Type: application/x-www-form-urlencoded\r\n\r\n")
        
        let router = Router(request: request)
        
        
        XCTAssertEqual(router.getRoute().getResponseStatusCode(method: .Get), "405")
    }
    
    func testReturnsOptionsRouteWhenMethodIsOptions() {
        Configuration.enableLogging = false
        let request = Request(requestString: "OPTIONS / HTTP/1.1\r\nHost: localhost:5000\r\nUser-Agent: curl/7.43.0\r\nAccept: */*\r\nContent-Length: 0\r\nContent-Type: application/x-www-form-urlencoded\r\n\r\n")
        
        let router = Router(request: request)
        
        
        XCTAssertEqual(router.getRoute().getResponseHeaders(uri: "/", method: .Options, requestBody: "")["Allow"], "GET")
    }
    
    
    
}
