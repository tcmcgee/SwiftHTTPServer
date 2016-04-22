import Foundation

class SwiftSocket: NSObject {
    var defaultPort : UInt16 = 5000
    var listeningHandle : NSFileHandle? = nil
    
    func getSocket(port : UInt16?) -> CFSocketNativeHandle? {
        if let socket : CFSocket = createUnboundSocket() {
            let nativeSocket = CFSocketGetNative(socket)
            var reuse = true
            if  (setsockopt(nativeSocket, SOL_SOCKET, SO_REUSEADDR, &reuse, socklen_t(sizeof(Int32))) != 0) {
                print("ERROR SETTING SOCKET OPTIONS")
                return nil
            }
            var address: sockaddr_in = prepareSocketAddress()
            let bindingSocketSuccess = bindSocket(socket: socket, pointer: &address)
            if (!bindingSocketSuccess) {
                print("UNABLE TO BIND SOCKET")
                return nil
            }
            return nativeSocket
        } else {
            print("UNABLE TO CREATE SOCKET")
            return nil
        }
    }
    
    func prepareSocketAddress() -> sockaddr_in {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        zeroAddress.sin_port = defaultPort.bigEndian
        return zeroAddress
    }
    
    func bindSocket(socket : CFSocket, pointer : UnsafePointer<sockaddr_in>) -> Bool {
        let socketAddressData = CFDataCreate(nil, UnsafePointer<UInt8>(pointer), sizeof(sockaddr_in))
        return CFSocketSetAddress(socket, socketAddressData) == CFSocketError.success
    }
    
    func createUnboundSocket() -> CFSocket {
        return CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP,0, nil, nil)
    }
    
}