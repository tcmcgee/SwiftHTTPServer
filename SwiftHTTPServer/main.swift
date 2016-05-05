import Foundation

let cmdArgs = Process.arguments

let port = cmdArgs[2]
let publicDir = cmdArgs[4]

Configuration.port = UInt16(port)!
Configuration.publicDirectory = publicDir

let server = HTTPServer()
server.start()
NSRunLoop.main().run()
