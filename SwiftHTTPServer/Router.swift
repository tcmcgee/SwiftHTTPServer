class Router {
    let request: Request
    var routeNotFound = NotFoundRoute()
    var methodNotAllowedRoute = NotAllowedRoute()
    
    init(request: Request) {
        self.request = request
    }
    
    func getRoute() -> Route {
        let routes = Configuration.routes
        if let route = routes.get(uri: request.baseURI!) {
            let allowedMethods = routes.getAllowedMethods(uri: request.baseURI!)
            if (request.method == .Options) {
                return OptionsRoute(allowedMethods: allowedMethods)
            }
            else if (allowedMethods.contains(request.method)) {
                return route[request.method]!
            } else {
                return methodNotAllowedRoute
            }
        } else {
            return routeNotFound
        }
        
    }
}
