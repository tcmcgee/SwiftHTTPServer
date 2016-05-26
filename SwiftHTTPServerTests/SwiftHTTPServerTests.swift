import XCTest
import Foundation

class SwiftHTTPServerTests: XCTestCase {
    let server = HTTPServer()
    override func setUp() {
        super.setUp()
        server.start()
    }
    
    override func tearDown() {
        super.tearDown()
        server.stop()
    }    
}
