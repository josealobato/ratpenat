import Foundation

// Temporary solution to have a mutable data store

class CategoryStorage: Identifiable, Codable {

    public let id: String
    public var title: String
    public var imageURL: URL?

    // This is the FS symbol associated with every.
    // one like `text.book.closed` can be set by default.
    public var defaultImage: String
}

class LectureStorage: Identifiable, Codable {

    public let id: String
    public var title: String
    public var categoryId: String?
    public var mediaURL: URL
    public var imageURL: URL?
    public var queuePosition: Int?
    public var playPosition: Int?

    public enum State: String, Codable {
        case new
        case managed
        case archived
    }
    public var state: State

    init(id: String,
         title: String,
         categoryId: String?,
         mediaURL: URL,
         imageURL: URL? = nil,
         queuePosition: Int? = nil,
         playPosition: Int? = nil,
         state: State = State.new) {

        self.id = id
        self.title = title
        self.categoryId = categoryId
        self.mediaURL = mediaURL
        self.imageURL = imageURL
        self.queuePosition = queuePosition
        self.playPosition = playPosition
        self.state = state
    }
}

struct StorageData: Codable {

    var lectures: [LectureStorage]
    var categories: [CategoryStorage]
}
