class Router{
    var uri: String?
    var uriTypeDict = Dictionary<String,Route>()
    var routeNotFound = NotFoundRoute(allowedMethods: "GET,OPTIONS")
    
    init(uri: String, method: String,body: String?) {
        self.uri = uri
        initializeRouterDict()
    }
    
    func initializeRouterDict() {
        uriTypeDict["/method_options"]  = BasicRoute(allowedMethods: "GET,OPTIONS,HEAD,POST,PUT,DELETE")
        uriTypeDict["/method_options2"] = BasicRoute(allowedMethods: "GET,OPTIONS")
        uriTypeDict["/"] = BasicRoute(allowedMethods: "GET, OPTIONS")
        uriTypeDict["/form"] = FormRoute(allowedMethods: "GET,OPTIONS,PUT,POST,DELETE")
        uriTypeDict["/parameters"] = ParameterRoute(allowedMethods: "GET,OPTIONS")
        uriTypeDict["/redirect"] = RedirectRoute(allowedMethods: "GET,OPTIONS,REDIRECT")
    }
    
    func getRoute() -> Route {
        return uriTypeDict.get(key: uri!,defaultValue: routeNotFound)
    }
    
    func setRoute(uri: String, route: Route) {
        uriTypeDict[uri] = route
    }
}
