import XCTest

class DictionaryDefaultValueTests: XCTestCase {
    
    func testDictionaryReturnsWithDefaultValue() {
        let dict: Dictionary<String,String> = Dictionary<String,String>()
        
        let defaultValue = "default"
        
        let retrievedValue = dict.get(key: "NotHere", defaultValue: "default")
        
        XCTAssertEqual(retrievedValue, defaultValue)
        
    }
}
