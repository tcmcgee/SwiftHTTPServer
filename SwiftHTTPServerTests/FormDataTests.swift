import XCTest

class FormDataTests: XCTestCase {
    var fileOperations : FileOperations?
    let file = "test.txt"
    let fileManager = NSFileManager()
    
    
    override func setUp() {
        super.setUp()
        fileOperations = FileOperations(file: "test.txt", pathToDir: "./")
        fileOperations!.file = "test.txt"
    }
    
    override func tearDown() {
        super.tearDown()
        fileOperations!.Delete()
    }
    
    func testWrite() {
        
        fileOperations!.Write(string: "TESTING")
        
        let readText = LocalRead()
        
        XCTAssertEqual(readText, "TESTING")
        
    }
    
    func testRead() {
        LocalWrite(string: "TESTING123")
        
        let readText = fileOperations!.Read()
        let readTextString = NSString(bytes: readText,length: readText.count, encoding: NSUTF8StringEncoding)
        
        XCTAssertEqual(readTextString, "TESTING123")
    }
    
    func testDelete() {
        LocalWrite(string: "_")
        let filePath = fileManager.currentDirectoryPath + "/" + file
        

        XCTAssert(fileManager.fileExists(atPath: filePath))
        
        fileOperations!.Delete()
    
        XCTAssertFalse(fileManager.fileExists(atPath: filePath))
    }
    
    func testWriteFormAction() {
        
        fileOperations!.formAction(method: "POST", body: "TESTING")
        
        let readText = LocalRead()
        
        XCTAssertEqual(readText, "TESTING")
        
    }
    
    func testDeleteFormAction() {
        LocalWrite(string: "_")
        let filePath = fileManager.currentDirectoryPath + "/" + file
        
        
        XCTAssert(fileManager.fileExists(atPath: filePath))
        
        fileOperations!.formAction(method: "DELETE", body: "")
        
        XCTAssertFalse(fileManager.fileExists(atPath: filePath))
    }



///////////// HELPERS /////////////
    
    func LocalWrite(string : String) {
        if let dir : String = fileManager.currentDirectoryPath {
            do {
                let filePath = (dir + "/" + file)
                try string.write(toFile: filePath, atomically: true, encoding: NSUTF8StringEncoding)
            }
            catch {
                print("ERROR WRITING TO FILE")
            }
        }
    }
    
    
    func LocalRead() -> String {
        var text2 : String?
        if let dir : String = fileManager.currentDirectoryPath {
            let filePath = (dir + "/" + file)
            do {
                text2 = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding) as String
            }
            catch {
                text2 = ""
            }
            
        }
        return text2!
    }

}
