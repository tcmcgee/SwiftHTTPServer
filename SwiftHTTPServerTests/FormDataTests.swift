import XCTest

class FormDataTests: XCTestCase {
    var formData : FormData?
    let file = "test.txt"
    let fileManager = NSFileManager()
    
    
    override func setUp() {
        super.setUp()
        formData = FormData()
        formData!.file = "test.txt"
    }
    
    override func tearDown() {
        super.tearDown()
        formData!.Delete()
    }
    
    func testWrite() {
        
        formData!.Write(string: "TESTING")
        
        let readText = LocalRead()
        
        XCTAssertEqual(readText, "TESTING")
        
    }
    
    func testRead() {
        LocalWrite(string: "TESTING123")
        
        let readText = formData!.Read()
        
        XCTAssertEqual(readText, "TESTING123")
    }
    
    func testDelete() {
        LocalWrite(string: "_")
        let filePath = fileManager.currentDirectoryPath + "/" + file
        

        XCTAssert(fileManager.fileExists(atPath: filePath))
        
        formData!.Delete()
    
        XCTAssertFalse(fileManager.fileExists(atPath: filePath))
    }
    
    func testWriteFormAction() {
        
        formData!.formAction(method: "POST", body: "TESTING")
        
        let readText = LocalRead()
        
        XCTAssertEqual(readText, "TESTING")
        
    }
    
    func testDeleteFormAction() {
        LocalWrite(string: "_")
        let filePath = fileManager.currentDirectoryPath + "/" + file
        
        
        XCTAssert(fileManager.fileExists(atPath: filePath))
        
        formData!.formAction(method: "DELETE", body: "")
        
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
