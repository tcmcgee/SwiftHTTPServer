import Foundation

class Router{
    var uri: String?
    var uriTypeDict = Dictionary<String,Route>()
    var routeNotFound = NotFoundRoute(allowedMethods: "GET,OPTIONS")
    let URIs = NSMutableSet(objects: "/method_options", "/method_options2", "/form", "/", "/parameters")
    
    init(uri: String, method: String,body: String?) {
        self.uri = uri
        initializeRouterDict()
    }
    
    func initializeRouterDict() {
        uriTypeDict["/method_options"]  = BasicRoute(allowedMethods: "GET,OPTIONS,HEAD,POST,PUT,DELETE")
        uriTypeDict["/method_options2"] = BasicRoute(allowedMethods: "GET,OPTIONS")
        uriTypeDict["/"] = BasicRoute(allowedMethods: "GET, OPTIONS")
        uriTypeDict["/form"] = FormRoute(allowedMethods: "GET,OPTIONS,PUT,POST,DELETE")
        uriTypeDict["/parameters"] = BasicRoute(allowedMethods: "GET,OPTIONS")
    }
    
    func getRoute() -> Route? {
        return uriTypeDict.get(key: uri!,defaultValue: routeNotFound)
    }
    
    func addURI(uri: String) {
        URIs.add(uri)
    }
    
    func removeURI(uri: String) {
        URIs.remove(uri)
    }
}
