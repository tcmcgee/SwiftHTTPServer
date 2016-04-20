import Foundation

class Request{
    
    var method = ""
    var URI : String? = ""
    var bodyData: NSData?
    
    init(requestString : String){
        
        
    }
    
    func getHead(requestString: String) -> String{
        let requestArray = split(string: requestString, separator: "\r\n\r\n")
        return requestArray[0]
    }
    
    func getBody(requestString: String) -> String{
        let requestArray = split(string: requestString, separator: "\r\n\r\n")
        return requestArray[1]
    }
    
    func getStatusLine(head: String) -> String{
        let headArray = split(string: head, separator: "\r\n")
        
        return headArray[0]
    }
    
    func split(string: String, separator: String) -> Array<String>
    {
            return string.components(separatedBy: separator)
    }
    
    
}