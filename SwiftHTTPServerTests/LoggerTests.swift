import XCTest

class LoggerTests: XCTestCase {

    let logger = Logger(fileName: "/log.txt", pathToDir: ".")
    let fileOperations = FileOperations(file:"/log.txt", pathToDir: ".")
    
    override func setUp() {
        super.setUp()
        fileOperations.Write(string: "TEST")
    }
    
    override func tearDown() {
        fileOperations.Delete()
    }
    
    func testLog() {
        logger.log(string: "testing")
        let testingBytes: [UInt8] = [116, 101, 115, 116, 105, 110, 103]
        
        let fileContents = fileOperations.Read()
        for byte in testingBytes {
            XCTAssert(fileContents.contains(byte))
        }
    }
    
    
    func testLogKeepsContents() {
        logger.log(string: "testing")
        let testingBytes: [UInt8] = [116, 101, 115, 116, 105, 110, 103]
        logger.log(string: "")
        
        let fileContents = fileOperations.Read()
        for byte in testingBytes {
            XCTAssert(fileContents.contains(byte))
        }
    }
    
}
