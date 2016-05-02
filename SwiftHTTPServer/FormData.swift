import Foundation

class FormData {
    
    var file = "form.txt"
    let fileManager = NSFileManager.defaultManager()
    
    
    func formAction(method: String, body: String?) {
        if (method == "POST" || method == "PUT") {
            Write(string: body!)
        }
        else if (method == "DELETE") {
            Delete()
        }
    }
    func Write(string : String) {
        if let dir : String = fileManager.currentDirectoryPath {
            do {
                let filePath = (dir + "/" + file)
                try string.write(toFile: filePath, atomically: true, encoding: NSUTF8StringEncoding)
            }
            catch {
                print("ERROR WRITING TO FILE")
            }
        }
    }

    func Read() -> String {
        var text2 : String?
        if let dir : String = fileManager.currentDirectoryPath {
            let filePath = (dir + "/" + file)
            do {
                text2 = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding) as String
            }
            catch {
                text2 = ""
            }
            
        }
        return text2!
    }
    
    func Delete() {
        if let dir : String = fileManager.currentDirectoryPath {
            do {
                let filePath = (dir + "/" + file)
                try fileManager.removeItem(atPath: filePath)
            }
            catch {
            }
        }
    }



}
