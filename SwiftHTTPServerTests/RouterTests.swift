import XCTest

class RouterTests: XCTestCase {
    
    var router = Router(uri: "/Filler",method:"FILLER",body:"FILLER")
    
    func testAddURI() {
        router.addURI(uri: "/MyURI")
        
        XCTAssert(router.URIs.contains("/MyURI"))
    }
    
    func testremoveURI(){
        router.URIs.add("/RemoveThis")
        
        router.removeURI(uri: "/RemoveThis")
        
        XCTAssertFalse(router.URIs.contains("RemoveThis"))
    }
    
    func testGetRoute() {
        let expectedRoute: Route = BasicRoute(allowedMethods: "GET,OPTIONS")
        router = Router(uri:"/method_options2",method:"OPTIONS",body:nil)
        
        let route = router.getRoute()!
        
        XCTAssert(route.dynamicType == expectedRoute.dynamicType)
        XCTAssertEqual(route.getAllowedMethods(), expectedRoute.getAllowedMethods())
    }
    
}
