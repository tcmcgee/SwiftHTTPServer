import Foundation

let cmdArgs = Process.arguments

let port = cmdArgs[2]
let publicDir = cmdArgs[4]
let logDir = cmdArgs[6]

Configuration.port = UInt16(port)!
Configuration.publicDirectory = publicDir
Configuration.logDirectory = logDir
Configuration.enableLogging = true

Configuration.routes.add(uri: "/method_options", method: .Get, route: BasicRoute())
Configuration.routes.add(uri: "/method_options", method: .Options, route: BasicRoute())
Configuration.routes.add(uri: "/method_options", method: .Head, route: BasicRoute())
Configuration.routes.add(uri: "/method_options", method: .Post, route: BasicRoute())
Configuration.routes.add(uri: "/method_options", method: .Put, route: BasicRoute())
Configuration.routes.add(uri: "/method_options", method: .Delete, route: BasicRoute())

Configuration.routes.add(uri: "/method_options2", method: .Get, route: BasicRoute())
Configuration.routes.add(uri: "/method_options2", method: .Options, route: BasicRoute())

Configuration.routes.add(uri: "/", method: .Get, route: DirectoryListRoute())

Configuration.routes.add(uri: "/form", method: .Get, route: FormRoute())
Configuration.routes.add(uri: "/form", method: .Put, route: FormRoute())
Configuration.routes.add(uri: "/form", method: .Post, route: FormRoute())
Configuration.routes.add(uri: "/form", method: .Delete, route: FormRoute())

Configuration.routes.add(uri: "/parameters", method: .Get, route: ParameterRoute())

Configuration.routes.add(uri: "/redirect", method: .Get, route: RedirectRoute())
Configuration.routes.add(uri: "/redirect", method: .Redirect, route: RedirectRoute())

Configuration.routes.add(uri: "/logs", method: .Get, route: BasicAuthRoute())


let fileNames = DirectoryListRoute.getFilesArray(publicDir: Configuration.publicDirectory)


for file in fileNames {
    Configuration.routes.add(uri:"/\(file)", method: .Get, route: FileServingRoute())
    Configuration.routes.add(uri:"/\(file)", method: .Patch, route: FileServingRoute())
}

let server = HTTPServer()
server.start()
NSRunLoop.main().run()


