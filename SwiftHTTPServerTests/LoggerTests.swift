import XCTest

class LoggerTests: XCTestCase {
    
    let fileOperations = FileOperations(file:"/log.txt", pathToDir: ".")
    
    override func setUp() {
        super.setUp()
        Configuration.enableLogging = true
        fileOperations.write(string: "TEST")
    }
    
    override func tearDown() {
        fileOperations.delete()
    }
    
    func testLog() {
        
        Logger.log(fileName: "/log.txt", pathToDir: ".", string: "testing")
        let testingBytes: [UInt8] = [116, 101, 115, 116, 105, 110, 103]
        
        let fileContents = fileOperations.read()
        for byte in testingBytes {
            XCTAssert(fileContents.contains(byte))
        }
    }
    
    
    func testLogKeepsContents() {
        Logger.log(fileName: "/log.txt", pathToDir: ".", string: "testing")
        let testingBytes: [UInt8] = [116, 101, 115, 116, 105, 110, 103]
        Logger.log(fileName: "/log.txt", pathToDir: ".", string: "")
        
        let fileContents = fileOperations.read()
        for byte in testingBytes {
            XCTAssert(fileContents.contains(byte))
        }
    }
    
}
