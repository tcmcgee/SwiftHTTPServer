import XCTest

class RoutesTests: XCTestCase {

    func testAddRouteDoesNotExistAlready() {
        let routes = Routes()
        
        routes.add(uri: "/test", method: .Get, route: FileServingRoute())
        
        XCTAssertNotNil(routes.routes["/test"])
        XCTAssertEqual(routes.routes["/test"]!.count, 1)
    }
    
    func testAddRouteDoesExistAlready() {
        let routes = Routes()
        
        routes.add(uri: "/test", method: .Get, route: FileServingRoute())
        XCTAssertEqual(routes.routes["/test"]!.count, 1)
        
        routes.add(uri: "/test", method: .Post, route: FileServingRoute())
        
        XCTAssertEqual(routes.routes["/test"]!.count, 2)
    }
    
    func testGetRoute() {
        
        let routes = Routes()
        let expectedResults: Dictionary<HTTPMethods, BasicRoute> = [.Get: FileServingRoute()]
        routes.routes["/test"] = [.Get: FileServingRoute()]
        
        XCTAssertEqual(expectedResults.count, routes.get(uri: "/test")!.count)
    }
    
    func testGetRouteDoesNotExist() {
        let routes = Routes()
        XCTAssertNil(routes.get(uri: "/Blah"))
    }
    
    func testGetAllowedMethods() {
        let routes = Routes()
        let expectedAllowedMethods: [HTTPMethods] = [.Get, .Post, .Put, .Delete, .Head]
        
        routes.add(uri: "/test", method: .Get, route: DirectoryListRoute())
        routes.add(uri: "/test", method: .Post, route: FileServingRoute())
        routes.add(uri: "/test", method: .Put, route: FileServingRoute())
        routes.add(uri: "/test", method: .Delete, route: FileServingRoute())
        routes.add(uri: "/test", method: .Head, route: BasicRoute())
        
        
        let allowedMethods = routes.getAllowedMethods(uri: "/test")
        for method in expectedAllowedMethods {
            XCTAssert(allowedMethods.contains(method))
        }
    }
    
    func testGetAllowedMethodsURIDoesNotExist() {
        let routes = Routes()
        XCTAssertEqual(routes.getAllowedMethods(uri: "/Blah"), [HTTPMethods]())
    }


}
