import Foundation


var port : UInt16 = 5000
if (Process.arguments.count > 1) {
    port = UInt16(Process.arguments[1])!
}
let server = HTTPServer()
server.start(port: port)
NSRunLoop.main().run()
