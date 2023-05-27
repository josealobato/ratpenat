import Foundation

public struct CategoryStorage: Identifiable, Codable {

    public let id: String
    public let title: String
    public let imageURL: URL?

    // This is the FS symbol associated with every.
    // one like `text.book.closed` can be set by default.
    public let defaultImage: String
}

public struct LectureStorage: Identifiable, Codable {

    public let id: String
    public let title: String
    public let categoryId: String
    public let mediaURL: URL
    public let imageURL: URL?
    public var queuePosition: Int?
    public var playPosition: Int?
}

struct StorageData: Codable {

    let lectures: [LectureStorage]
    let categories: [CategoryStorage]
}
