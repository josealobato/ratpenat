import Foundation

public struct CategoryDataEntity: Identifiable {

    public let id: String
    public let title: String
    public let imageURL: URL?

    // This is the FS symbol associated with every.
    // one like `text.book.closed` can be set by default.
    public let defaultImage: String
}

// MARK: - Storage Extensions to get the entities from data
// This is placed here because storage should not know about data.
// In the future Storage can be extracted to its own module.

extension CategoryStorage {

    var dataEntity: CategoryDataEntity {

        CategoryDataEntity(id: id,
                           title: title,
                           imageURL: imageURL,
                           defaultImage: defaultImage)

    }

}

// Temporary solution to have a mutable data store

extension MutableCategoryStorage {

    var dataEntity: CategoryDataEntity {

        CategoryDataEntity(id: id,
                           title: title,
                           imageURL: imageURL,
                           defaultImage: defaultImage)

    }

}
