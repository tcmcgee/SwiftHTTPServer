class Router {
    var uri: String?
    var uriTypeDict = Dictionary<String,Route>()
    let method = HTTPMethods(rawValue: "GET")
    var routeNotFound = NotFoundRoute(allowedMethods: [.Get, .Options])
    
    init(uri: String, method: String,body: String?) {
        self.uri = uri
    }
    
    func initializeRouterDict() {
        uriTypeDict["/method_options"]  = BasicRoute(allowedMethods: [.Get, .Options, .Head, .Post, .Put, .Delete])
        uriTypeDict["/method_options2"] = BasicRoute(allowedMethods: [.Get, .Options])
        uriTypeDict["/"] = DirectoryListRoute(allowedMethods: [.Get, .Options])
        uriTypeDict["/form"] = FormRoute(allowedMethods: [.Get, .Options, .Put, .Post, .Delete])
        uriTypeDict["/parameters"] = ParameterRoute(allowedMethods: [.Get, .Options])
        uriTypeDict["/redirect"] = RedirectRoute(allowedMethods: [.Get, .Options, .Redirect])
        uriTypeDict["/file1"] = FileServingRoute(allowedMethods: [.Get, .Options])
        uriTypeDict["/text-file.txt"] = FileServingRoute(allowedMethods: [.Get, .Options])
        uriTypeDict["/image.jpeg"] = FileServingRoute(allowedMethods: [.Get, .Options])
        uriTypeDict["/logs"] = BasicAuthRoute(allowedMethods: [.Get])
        addDynamicRoutes()
    }
    
    func getRoute() -> Route {
        return uriTypeDict.get(key: uri!,defaultValue: routeNotFound)
    }
    
    func addDynamicRoutes() {
        let fileNames = DirectoryListRoute.getFilesArray(publicDir: Configuration.publicDirectory)
        
        
        for file in fileNames {
            uriTypeDict["/\(file)"] = FileServingRoute(allowedMethods: [.Get, .Options, .Patch])
        }
    }
    
    func setRoute(uri: String, route: Route) {
        uriTypeDict[uri] = route
    }
}
