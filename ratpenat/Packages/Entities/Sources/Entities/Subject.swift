import Foundation

public struct Subject: Identifiable, Equatable {
    public let id: Int
    public let name: String
    public let color: String
    
    public init(id: Int,
                name: String,
                color: String) {
        self.id = id
        self.name = name
        self.color = color
    }
}
