import Foundation

extension Dictionary {
    public var description: String {
        String(
            data: try! JSONSerialization.data(
                withJSONObject: self,
                options: .prettyPrinted
            ),
            encoding: .utf8
        )!
    }
}

extension Dictionary where Key == String, Value == String {
    public func serializedURLQuery() -> String {
        var queryCharSet = NSCharacterSet.urlHostAllowed
        queryCharSet.insert(charactersIn: ".")
        return self.sorted { $0.key < $1.key }
            .map {
                let key = $0.key.addingPercentEncoding(withAllowedCharacters: queryCharSet)!
                let value = $0.value.replacingOccurrences(of: " ", with: "+")
                    .addingPercentEncoding(withAllowedCharacters: queryCharSet)!
                return "\(key)=\(value)"
            }
            .joined(separator: "&")
    }
}
