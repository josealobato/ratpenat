import Foundation

// Temporary solution to have a mutable data store

public class MutableCategoryStorage: Identifiable, Codable {

    public let id: String
    public var title: String
    public var imageURL: URL?

    // This is the FS symbol associated with every.
    // one like `text.book.closed` can be set by default.
    public var defaultImage: String
}

public class MutableLectureStorage: Identifiable, Codable {

    public let id: String
    public var title: String
    public var categoryId: String
    public var mediaURL: URL
    public var imageURL: URL?
    public var queued: Bool
}

struct MutableStorageData: Codable {

    var lectures: [MutableLectureStorage]
    var categories: [MutableCategoryStorage]
}
