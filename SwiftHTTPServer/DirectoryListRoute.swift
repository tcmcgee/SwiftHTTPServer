#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

class DirectoryListRoute: BasicRoute {
    
    override func getResponseBody(uri: String, method: String, requestHeaders: Dictionary<String,String>, requestBody: String?) -> [UInt8] {
        let files = DirectoryListRoute.getFilesArray(publicDir: Configuration.publicDirectory)
        var htmlBody: String = "<!DOCTYPE html> <html> <body> <ul>"
        
        for file in files {
            if (file.characters.first != "."){
                htmlBody += "<li> <a href=/\(file)>\(file)</a> </li>"
            }
        }
        
        htmlBody += "</ul> </body> <br> </html>"
        return removeNullBytes(byteArray: getByteArrayFromString(string: htmlBody))
    }
    
    static func getFilesArray(publicDir: String) -> [String] {
        var files : [String] = [String]()
        var d : UnsafeMutablePointer<DIR>;
        
        d = Darwin.opendir(publicDir)
        while let dir: UnsafeMutablePointer<dirent> = Darwin.readdir(d){
            var d_name = dir.pointee.d_name
            var name = ""
            withUnsafePointer(&d_name) {
                name = String(cString: UnsafePointer<Int8>($0))
                files.append(name)
            }
        }
        closedir(d);
        return files
    }
    
    
}
