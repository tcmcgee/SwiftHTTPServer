import XCTest

class RouterTests: XCTestCase {
    
    var router = Router(uri: "/Filler")
    
    func testAddURI() {
        router.addURI(uri: "/MyURI")
        
        XCTAssert(router.URIs.contains("/MyURI"))
    }
    
    func testremoveURI(){
        router.URIs.add("/RemoveThis")
        
        router.removeURI(uri: "/RemoveThis")
        
        XCTAssertFalse(router.URIs.contains("RemoveThis"))
    }
    
    func testIsAllowedURI() {
        router = Router(uri: "/Allowed")

        router.URIs.add("/Allowed")

        XCTAssert(router.isAllowedURI())
    }

    func testIsNotAllowedURI() {
        router = Router(uri: "/NotAllowed")

        XCTAssertFalse(router.isAllowedURI())
    }
    
    func testGetAllowedMethods() {
        router = Router(uri: "/method_options2")
        
        let expectedMethods = NSMutableSet(objects: "GET", "OPTIONS")
        
        XCTAssertEqual(expectedMethods, router.getAllowedMethods())
    }
    
    func testIsAllowedMethod() {
        router = Router(uri: "/method_options2")
        
        XCTAssert(router.isAllowedMethod(method: "GET"))
    }
    
    
    
}
