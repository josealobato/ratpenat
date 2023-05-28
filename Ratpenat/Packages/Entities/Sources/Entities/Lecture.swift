import Foundation

public struct Lecture: Identifiable, Equatable {

    public var id: String
    public var title: String
    public var category: Category?
    public var mediaURL: URL
    public let imageURL: URL?
    public var queuePosition: Int?
    public var playPosition: Int?

    public let defaultImageName: String = "book.closed"

    public init(id: String,
                title: String,
                category: Category? = nil,
                mediaURL: URL,
                imageURL: URL? = nil,
                queuePosition: Int? = nil,
                playPosition: Int? = nil
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.mediaURL = mediaURL
        self.imageURL = imageURL
        self.queuePosition = queuePosition
        self.playPosition = playPosition
    }

    public var isStacked: Bool { queuePosition != nil }
    public var isPlaying: Bool { playPosition != nil }
}

// MARK: - Image
//         Here we can add the management of the image to be displayed.
