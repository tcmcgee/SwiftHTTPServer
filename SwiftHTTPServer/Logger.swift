#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

class Logger {
    var fileName: String = ""
    var pathToDir: String = ""
    
    init(fileName: String, pathToDir: String) {
        self.fileName = fileName
        self.pathToDir = pathToDir
    }
    
    static func log(fileName: String, pathToDir: String, string: String) {
        if (Configuration.enableLogging){
            let logger = FileOperations(file: fileName, pathToDir: pathToDir)
            let logString = Logger.getCurrentTime() + string + "\n"
            
            logger.append(string: logString)
        }
    }
    
    static func getCurrentTime() -> String {
        var myTime = time(nil)
        let current_time = "[ \(String(cString: strtok(ctime(&myTime),"\n"))) ] "
        return current_time
    }
}