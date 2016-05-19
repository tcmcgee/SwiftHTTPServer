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
            Write(string: body!)
        }
        else if (method == "DELETE") {
            Delete()
        }
    }
    
    func Write(string : String) {
        let pathToFile = "\(pathToDir)\(file)"
        let writeFile = fopen (pathToFile, "w")
        fputs(string, writeFile)
        fclose(writeFile)
    }
    
    func Read() -> [UInt8] {
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
    
    func ReadPartial(start: Int, end: Int) -> [UInt8] {
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
    
    
    func Delete() {
        let pathToFile = "\(pathToDir)\(file)"
        if( access( pathToFile, F_OK ) != -1 ) {
            unlink(pathToFile)
        }
    }
    
    
}
