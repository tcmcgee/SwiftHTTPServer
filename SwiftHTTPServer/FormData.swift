#if os(Linux)
import Glibc
#else
import Darwin.C
#endif

class FormData {
    
    var file = "form.txt"
    
    func formAction(method: String, body: String?) {
        if (method == "POST" || method == "PUT") {
            Write(string: body!)
        }
        else if (method == "DELETE") {
            Delete()
        }
    }

    func Write(string : String) {
        let pathToFile = "./\(file)"
        let writeFile = fopen (pathToFile, "w")
        fputs(string, writeFile)
        fclose(writeFile)
    }

    func Read() -> String {
        
        let pathToFile = "./\(file)"
        
        if( access( pathToFile, F_OK ) == -1 ) {
            Write(string: "")
        }
        
        let readFile = fopen (pathToFile, "r")
        let readString : UnsafeMutablePointer<Int8> = UnsafeMutablePointer(allocatingCapacity: 256)
        fgets(readString, 256, readFile)
        let string = String(cString: readString)
        
        return string.characters.count > 0 ? string : ""
    }
    
    func Delete() {
        let pathToFile = "./\(file)"
        if( access( pathToFile, F_OK ) != -1 ) {
            unlink(pathToFile)
        }
    }



}
