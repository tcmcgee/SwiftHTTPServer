import Foundation

class FormData {
    
    let file = "form.txt"
    let fileManager = NSFileManager.defaultManager()
    
    func Write(string : String)
    {
        if let dir : String = fileManager.currentDirectoryPath {
            do{
                let filePath = (dir + "/" + file)
                print(filePath)
                try string.write(toFile: (dir + "/" + file), atomically: true, encoding: NSUTF8StringEncoding)
            }
            catch{
                print("Error")
            }
        }

    }

}
