import Foundation

public struct Lecture: Identifiable, Equatable {

    public var id: String
    public var title: String
    public var category: Category?
    public var mediaURL: URL
    public let imageURL: URL?
    public let isStacked: Bool

    public let defaultImageName: String = "book.closed"

    public init(id: String,
                title: String,
                category: Category?,
                mediaURL: URL,
                imageURL: URL?,
                isStacked: Bool = false
    ) {
        self.id = id
        self.title = title
        self.category = category
        self.mediaURL = mediaURL
        self.imageURL = imageURL
        self.isStacked = isStacked
    }
}

// MARK: - Image
//         Here we can add the management of the image to be displayed.
