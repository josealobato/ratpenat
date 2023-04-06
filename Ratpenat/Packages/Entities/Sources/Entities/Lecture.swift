import Foundation

public struct Lecture: Identifiable, Equatable {

    public var id: String
    public var title: String
    public var location: URL

    public init(id: String, title: String, location: URL) {
        self.id = id
        self.title = title
        self.location = location
    }
}
