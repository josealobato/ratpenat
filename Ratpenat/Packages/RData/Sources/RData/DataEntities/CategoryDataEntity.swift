import Foundation

public struct CategoryDataEntity: Identifiable, Equatable {

    public let id: UUID
    public let title: String
    public let imageURL: URL?

    // This is the FS symbol associated with every.
    // one like `text.book.closed` can be set by default.
    public let defaultImage: String

    public init(id: UUID,
         title: String,
         imageURL: URL?,
         defaultImage: String) {
        
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.defaultImage = defaultImage
    }
}

// MARK: - Storage Extensions to get the entities from data
// This is placed here because storage should not know about data.
// In the future Storage can be extracted to its own module.

// Temporary solution to have a mutable data store

extension CategoryStorage {

    var dataEntity: CategoryDataEntity {

        CategoryDataEntity(id: id,
                           title: title,
                           imageURL: imageURL,
                           defaultImage: defaultImage)

    }
}
