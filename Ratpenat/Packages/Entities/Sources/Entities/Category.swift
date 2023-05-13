import Foundation

public struct Category: Identifiable, Equatable {
    
    public let id: String
    public let title: String

    // A categorey will always have a default image
    // but the user can also create a category and assign an image.
    public let imageURL: URL?
    public let defaultImage: String
    
    public init(id: String,
                title: String,
                imageURL: URL?,
                defaultImage: String) {
        
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.defaultImage = defaultImage
    }
}
