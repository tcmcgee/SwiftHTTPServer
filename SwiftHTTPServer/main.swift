import Foundation


var port : UInt16 = 5000
let server = HTTPServer()
server.start(port: port)
NSRunLoop.main().run()
