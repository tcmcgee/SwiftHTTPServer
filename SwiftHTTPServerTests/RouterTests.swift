import XCTest

class RouterTests: XCTestCase {
    
    var router = Router(uri: "/Filler",method:"FILLER",body:"FILLER")
    
    func testInitialiazeRouterDict() {
        router.uriTypeDict = Dictionary<String,Route>()
        
        router.initializeRouterDict()
        
        XCTAssert(router.uriTypeDict.count > 0)
    }
    
    func testSetRoute() {
        router.uriTypeDict = Dictionary<String,Route>()
        
        router.setRoute(uri: "/Test", route: BasicRoute(allowedMethods: "GET,OPTIONS"))
        
        XCTAssert(router.uriTypeDict.keys.contains("/Test"))
        XCTAssert(router.uriTypeDict.count > 0)
    }
    
    func testGetRoute() {
        let expectedRoute: Route = BasicRoute(allowedMethods: "GET,OPTIONS")
        router = Router(uri:"/method_options2",method:"OPTIONS",body:nil)
        router.initializeRouterDict()
        
        let route = router.getRoute()
        
        XCTAssert(route.dynamicType == expectedRoute.dynamicType)
        XCTAssertEqual(route.getAllowedMethods(), expectedRoute.getAllowedMethods())
    }
    
    func testAddDynamicRoutes() {
        router = Router(uri: "/dynamic_rotes", method:"GET",body:nil)
        Configuration.publicDirectory = "."
        XCTAssert(router.uriTypeDict.values.count == 0)
        
        router.addDynamicRoutes()
        
        XCTAssert(router.uriTypeDict.values.count != 0)
    }
    
}
