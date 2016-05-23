import Foundation

let cmdArgs = Process.arguments

let port = cmdArgs[2]
let publicDir = cmdArgs[4]
let logDir = cmdArgs[6]

Configuration.port = UInt16(port)!
Configuration.publicDirectory = publicDir
Configuration.logDirectory = logDir

let server = HTTPServer()
server.start()
NSRunLoop.main().run()
