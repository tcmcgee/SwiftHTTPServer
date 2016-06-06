#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

import XCTest

class DirectoryListRouteTests: XCTestCase {

    var directoryListRoute = DirectoryListRoute(allowedMethods: [.Get, .Options])
    var currentDir: UnsafeMutablePointer<Int8>?
    var workingDir: String?


    override func setUp() {
        super.setUp()
        directoryListRoute = DirectoryListRoute(allowedMethods: [.Get, .Options])
        currentDir = UnsafeMutablePointer<Int8>(allocatingCapacity: 1000)
        workingDir = String(cString: getcwd(currentDir, 1000)) + "/"
    }
    
    override func tearDown() {
        super.tearDown()
        
        currentDir?.deallocateCapacity(1000)
    }
    
    func testGetFileNamesInFolder(){
        fopen("DirectoryListRoute.txt","w")
        let filesArray = DirectoryListRoute.getFilesArray(publicDir: workingDir!)
        
        XCTAssert(filesArray.contains("DirectoryListRoute.txt"))
        unlink("./DirectoryListRoute.txt")
    }
    
    func testGetResponseBodyNoElements(){
        mkdir("./testing123",0777)
        Configuration.publicDirectory = workingDir! + "testing123/"
        let response = directoryListRoute.getResponseBody(uri: "/YOLO", method: .Get, requestHeaders: Dictionary<String,String>(), requestBody: "")
        let responseString = NSString(bytes: response,length: response.count, encoding: NSUTF8StringEncoding)
        XCTAssert(responseString!.contains("<ul></ul>"))
        rmdir("./testing123")
    }
    
    func testGetResponseBodyWithElements(){
        Configuration.publicDirectory = workingDir!
        let response = directoryListRoute.getResponseBody(uri: "/YOLO", method: .Get, requestHeaders: Dictionary<String,String>(), requestBody: "")
        let responseString = NSString(bytes: response,length: response.count, encoding: NSUTF8StringEncoding)
        XCTAssertFalse(responseString!.contains("<ul></ul>"))
    }
    
    func testGetResponseBody(){
        Configuration.publicDirectory = workingDir!
        fopen("./Show.txt","w")
        
        let response = directoryListRoute.getResponseBody(uri: "/YOLO", method: .Get, requestHeaders: Dictionary<String,String>(), requestBody: "")
        let responseString = NSString(bytes: response,length: response.count, encoding: NSUTF8StringEncoding)
        
        XCTAssert(responseString!.contains("Show.txt"))
        unlink("./Show.txt")
    }


    func testGetResponseBodyNoDots(){
        Configuration.publicDirectory = workingDir!
        fopen("./.noShow.txt","w")
        let response = directoryListRoute.getResponseBody(uri: "/YOLO", method: .Get, requestHeaders: Dictionary<String,String>(), requestBody: "")
        let responseString = NSString(bytes: response,length: response.count, encoding: NSUTF8StringEncoding)
        
        XCTAssertFalse(responseString!.contains("noShow.txt"))
        unlink("./.noShow.txt")
    }

}