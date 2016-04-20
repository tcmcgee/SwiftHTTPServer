import Foundation


var port : UInt16?
if (Process.arguments.count > 1) {
    port = UInt16(Process.arguments[1])!
    print(port)
}
let server = HTTPServer()
server.start(port: port)
NSRunLoop.main().run()
