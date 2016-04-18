import Foundation

class HTTPServer: NSObject {
    let defaultPort : UInt16 = 5000
    var listeningHandle : NSFileHandle? = nil
    
    func start(){
        if let socket : CFSocket = createUnboundSocket() {
            let nativeSocket = CFSocketGetNative(socket)
            var reuse = true
            if  (setsockopt(nativeSocket, SOL_SOCKET, SO_REUSEADDR, &reuse, socklen_t(sizeof(Int32))) != 0) {
                print("ERROR SETTING SOCKET OPTIONS")
                return
            }
            var address: sockaddr_in = prepareSocketAddress()
            let bindingSocketSuccess = bindSocket(socket: socket, pointer: &address)
            if (!bindingSocketSuccess){
                print("UNABLE TO BIND SOCKET")
                return
            }
            prepareListeningHandle(nativeSocket: nativeSocket)
            if (listeningHandle != nil) {
                print ("Server started at localhost:\(defaultPort)")
                listeningHandle!.acceptConnectionInBackgroundAndNotify()
            }
            else {
                print("LISTENING HANDLE NOT PREPARED")
            }
            
        } else {
            print("UNABLE TO CREATE SOCKET")
        }
    }
    func receiveIncomingAcceptedConnectionNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo as? [String : AnyObject] {
            let incomingFileHandle = userInfo[NSFileHandleNotificationFileHandleItem] as? NSFileHandle
            if let data = incomingFileHandle?.availableData {
                let incomingRequest = CFHTTPMessageCreateEmpty(kCFAllocatorDefault, true).takeUnretainedValue() as CFHTTPMessage
                if CFHTTPMessageAppendBytes(incomingRequest, UnsafePointer<UInt8>(data.bytes), data.length) == true {
                    if CFHTTPMessageIsHeaderComplete(incomingRequest) == true {
                        let responseHandler = HTTPResponseHandler()
                        responseHandler.parseRequest(request: incomingRequest, fileHandle: incomingFileHandle!)
                        responseHandler.startResponse()
                    }
                }
            }
        }
        listeningHandle!.acceptConnectionInBackgroundAndNotify()
    }
    
    func prepareListeningHandle(nativeSocket: CFSocketNativeHandle){
        listeningHandle = NSFileHandle(fileDescriptor: nativeSocket, closeOnDealloc: true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(receiveIncomingAcceptedConnectionNotification), name: NSFileHandleConnectionAcceptedNotification, object: nil)
        
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
    
    func createUnboundSocket() -> CFSocket{
        return CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP,0, nil, nil)
    }
    
}