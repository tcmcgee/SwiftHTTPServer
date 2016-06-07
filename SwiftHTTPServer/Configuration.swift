class Configuration {
    
    static var publicDirectory = "./cob_spec/public"
    static var port: UInt16 = 5000
    static var logDirectory = "./logs"
    static var routes: Dictionary<String,Any> = ["/": Dictionary<HTTPMethods,Route>()]
}