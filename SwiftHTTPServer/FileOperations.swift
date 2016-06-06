#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

class FileOperations {
    
    var file = "form.txt"
    var pathToDir = "./"
    
    init(file: String, pathToDir: String) {
        self.file = file
        self.pathToDir = pathToDir
        
    }
    
    func formAction(method: String, body: String?) {
        if (method == "POST" || method == "PUT") {
            write(string: body!)
        }
        else if (method == "DELETE") {
            delete()
        }
    }
    
    func write(string : String) {
        let pathToFile = "\(pathToDir)\(file)"
        let writeFile = fopen (pathToFile, "w")
        fputs(string, writeFile)
        fclose(writeFile)
    }
    
    func append(string: String) {
        let pathToFile = "\(pathToDir)\(file)"
        let writeFile = fopen (pathToFile, "a")
        fputs(string, writeFile)
        fclose(writeFile)
    }
    
    func read() -> [UInt8] {
        let pathToFile = "\(pathToDir)\(file)"
        var int8Array2 = [UInt8]()
        if( access( pathToFile, F_OK ) != -1 ) {
            
            let readFile = fopen (pathToFile, "r")
            while(feof(readFile) == 0){
                let ch = fgetc(readFile)
                if (ch != -1){
                    int8Array2.append(UInt8(ch))
                }
            }
            return int8Array2
        } else {
            return [UInt8]()
        }
    }
    
    
    func readPartial(start: Int, end: Int) -> [UInt8] {
        let pathToFile = "\(pathToDir)\(file)"
        var int8Array2 = [UInt8]()
        if( access( pathToFile, F_OK ) != -1 ) {
            
            let readFile = fopen(pathToFile, "r")
            fseek(readFile, start, SEEK_SET)
            var currentIndex = start
            while(feof(readFile) == 0 && currentIndex != end + 1){
                let ch = fgetc(readFile)
                if (ch != -1){
                    int8Array2.append(UInt8(ch))
                }
                currentIndex += 1
            }
            fclose(readFile)
            return int8Array2
        } else {
            return [UInt8]()
        }
    }
    
    
    func delete() {
        let pathToFile = "\(pathToDir)\(file)"
        if( access( pathToFile, F_OK ) != -1 ) {
            unlink(pathToFile)
        }
    }
    
    
}
