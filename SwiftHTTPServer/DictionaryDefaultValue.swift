import Foundation
extension Dictionary {
    func get(key: Key, defaultValue: Value) -> Value {
        if let value = self[key] {
            return value
        } else {
            return defaultValue
        }
    }
}