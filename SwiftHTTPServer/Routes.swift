class Routes {
    var routes: Dictionary<String, Dictionary<HTTPMethods,BasicRoute>>
    
    init() {
        routes = ["/": [.Get: FileServingRoute()]]
    }
    
    func get(uri: String) -> Dictionary<HTTPMethods, BasicRoute>?{
        return routes[uri]
    }
    
    func add(uri: String, method: HTTPMethods, route: BasicRoute) {
        var existingRoute: Dictionary<HTTPMethods, BasicRoute> = routes[uri] ?? Dictionary<HTTPMethods, BasicRoute>()
        existingRoute[method] = route
        routes[uri] = existingRoute
    }
    
    func getAllowedMethods(uri: String) -> [HTTPMethods] {
        let keys = get(uri:uri)?.keys
        if (keys != nil) {
            return Array(keys!)
        } else {
            return [HTTPMethods]()
        }
    }
}