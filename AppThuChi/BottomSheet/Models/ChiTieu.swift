import Foundation

struct JSON {
    static let encoder = JSONEncoder()
}

extension Encodable {
    // convert data from object to dictionary
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
        
    }
    
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
}

struct ChiTieu: Codable {
    let id: String
    let money: Float
    let danhMuc: String
    let note: String
    let date: String
    let creatorId: String
}

struct ThuNhap: Codable {
    let id: String
    let money: Float
    let danhMuc: String
    let note: String
    let date: String
    let creatorId: String
}

