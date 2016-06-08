#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

import Foundation

class HTTPServer {
    
    func start(){
        var sockfd, newsockfd : Int32
        var serv_addr: sockaddr_in = sockaddr_in()
        var cli_addr = sockaddr_in()
        var n: Int = 1
        
        sockfd = socket(AF_INET, SOCK_STREAM, 0);
        
        if (sockfd < 0) {
            perror("ERROR opening socket");
            exit(1);
        }
        
        /* Initialize socket structure */
        
        serv_addr.sin_family = UInt8(AF_INET);
        serv_addr.sin_port = UInt16(Configuration.port).bigEndian;
        
        /* Now bind the host address using bind() call.*/
        
        withUnsafePointer(&serv_addr) {
            if (bind(sockfd, UnsafePointer($0), socklen_t(sizeofValue(serv_addr))) < 0) {
                perror("ERROR on binding");
                exit(1);
            }
        }
        
        print("Server is now running on localhost:\(Configuration.port)")
        
        /* Now start listening for the clients, here process will
         * go in sleep mode and will wait for the incoming connection
         */
        listen(sockfd,100)
        var clilen = socklen_t(sizeofValue(cli_addr))
        
        while(true) {
            /* Accept actual connection from the client */
            newsockfd =  withUnsafePointer(&cli_addr) {
                let mysockaddr: UnsafeMutablePointer<sockaddr> = UnsafeMutablePointer($0)
                return accept(sockfd, mysockaddr, &clilen)
            }
            
            if (newsockfd < 0) {
                perror("ERROR on accept");
                exit(1);
            }
            
            /* If connection is established then start communicating */
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0)) {
                let bufferSize = 1024
                var buffer = Array<UInt8>(repeating: 0, count: bufferSize)
                
                read(newsockfd,&buffer,1024)
                let myData = NSData(bytes: &buffer, length: buffer.count)
                let requestString = NSString(data: myData, encoding: NSUTF8StringEncoding )
                
                let responseGenerator = HTTPResponseGenerator()
                let response = responseGenerator.generateResponse(request: Request(requestString: requestString as! String))
                
                /* Write a response to the client */
                
                n = write(newsockfd,response,response.count);
                
                if (n < 0) {
                    perror("ERROR writing to socket");
                    exit(1);
                }
                
                
                close(newsockfd);
            }
            
        }
        close(sockfd)
    }
}