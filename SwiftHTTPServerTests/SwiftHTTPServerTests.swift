import XCTest
import Foundation

class SwiftHTTPServerTests: XCTestCase {
    let server = HTTPServer()
    override func setUp() {
        super.setUp()
        Configuration.port = 5001
        server.start()
    }
    
    override func tearDown() {
        super.tearDown()
        server.stop()
    }
    
    func testServerStartsPortOpen() {
        let isPortOpen = shell(args: "nc", "-z", "-v", "127.0.0.1", "\(Configuration.port)")
        XCTAssertEqual(isPortOpen, 0)
    }
    
    func shell(args: String...) -> Int32 {
        let task = NSTask()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
}
