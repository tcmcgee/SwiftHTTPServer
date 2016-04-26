import Foundation

class HTTPServer: NSObject {
    var listeningHandle : NSFileHandle? = nil
        
    func start(port : UInt16?) {
        let swiftSocket = SwiftSocket()
        let nativeSocket = swiftSocket.getSocket(port: port!)
        prepareListeningHandle(nativeSocket: nativeSocket!)
        if (listeningHandle != nil) {
            print ("Server started at localhost:\(port!)")
            listeningHandle!.acceptConnectionInBackgroundAndNotify()
        } else {
            print("LISTENING HANDLE NOT PREPARED")
        }
        
    }
    
    func prepareListeningHandle(nativeSocket: CFSocketNativeHandle) {
        listeningHandle = NSFileHandle(fileDescriptor: nativeSocket, closeOnDealloc: true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(receiveIncomingAcceptedConnectionNotification), name: NSFileHandleConnectionAcceptedNotification, object: nil)
    }
    
    func receiveIncomingAcceptedConnectionNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo as? [String : AnyObject] {
            let incomingFileHandle = userInfo[NSFileHandleNotificationFileHandleItem] as? NSFileHandle
            if let data = incomingFileHandle?.availableData {
                let incomingRequestString = String.init(data: data, encoding: NSUTF8StringEncoding)
                if (incomingRequestString!.characters.count > 0) {
                    let request : Request = Request(requestString: incomingRequestString!)
                    let responseHandler = HTTPResponseHandler()
                    responseHandler.startResponse(request: request, fileHandle: incomingFileHandle)
                }
            }
        }
        listeningHandle!.acceptConnectionInBackgroundAndNotify()
    }
}