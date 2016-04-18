import Foundation



let port : UInt16 = UInt16(Process.arguments[1])!
print(port)
let server = HTTPServer()
server.start(port: port)
NSRunLoop.main().run()
