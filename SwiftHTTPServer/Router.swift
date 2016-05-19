class Router{
    var uri: String?
    var uriTypeDict = Dictionary<String,Route>()
    var routeNotFound = NotFoundRoute(allowedMethods: "GET,OPTIONS")
    
    init(uri: String, method: String,body: String?) {
        self.uri = uri
    }
    
    func initializeRouterDict() {
        uriTypeDict["/method_options"]  = BasicRoute(allowedMethods: "GET,OPTIONS,HEAD,POST,PUT,DELETE")
        uriTypeDict["/method_options2"] = BasicRoute(allowedMethods: "GET,OPTIONS")
        uriTypeDict["/"] = DirectoryListRoute(allowedMethods: "GET, OPTIONS")
        uriTypeDict["/form"] = FormRoute(allowedMethods: "GET,OPTIONS,PUT,POST,DELETE")
        uriTypeDict["/parameters"] = ParameterRoute(allowedMethods: "GET,OPTIONS")
        uriTypeDict["/redirect"] = RedirectRoute(allowedMethods: "GET,OPTIONS,REDIRECT")
        uriTypeDict["/file1"] = FileServingRoute(allowedMethods: "GET,OPTIONS")
        uriTypeDict["/text-file.txt"] = FileServingRoute(allowedMethods: "GET,OPTIONS")
        uriTypeDict["/image.jpeg"] = FileServingRoute(allowedMethods: "GET,OPTIONS")
        addDynamicRoutes()
    }
    
    func getRoute() -> Route {
        return uriTypeDict.get(key: uri!,defaultValue: routeNotFound)
    }
    
    func addDynamicRoutes() {
        let fileNames = DirectoryListRoute.getFilesArray(publicDir: Configuration.publicDirectory)
        
        
        for file in fileNames {
            uriTypeDict["/\(file)"] = FileServingRoute(allowedMethods: "GET,OPTIONS")
        }
    }
    
    func setRoute(uri: String, route: Route) {
        uriTypeDict[uri] = route
    }
}
