
import XCTest

class ResponseTests: XCTestCase {

    var response : Response?
    
    override func setUp() {
        super.setUp()
        response = Response()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testSetResponse(){
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
    
    

}
