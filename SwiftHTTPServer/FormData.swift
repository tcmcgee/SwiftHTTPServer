import Foundation

class FormData {
    
    let file = "form.txt"
    let fileManager = NSFileManager.defaultManager()
    
    func Write(string : String)
    {
        if let dir : String = fileManager.currentDirectoryPath {
            do{
                let filePath = (dir + "/" + file)
                try string.write(toFile: (dir + "/" + file), atomically: true, encoding: NSUTF8StringEncoding)
            }
            catch{
                print("Error")
            }
        }

    }

    func Read() -> String{
        var text2 : String?
        if let dir : String = fileManager.currentDirectoryPath {
            let filePath = (dir + "/" + file)
            do {
                text2 = try NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding) as String
            }
            catch {
                print("ERROR")
            }
            
        }
        return text2!
    }
    
    func Delete()
    {
        if let dir : String = fileManager.currentDirectoryPath {
            do{
                let string : String = ""
                let filePath = (dir + "/" + file)
                try string.write(toFile: (dir + "/" + file), atomically: true, encoding: NSUTF8StringEncoding)
            }
            catch{
                print("Error")
            }
        }
    }



}
