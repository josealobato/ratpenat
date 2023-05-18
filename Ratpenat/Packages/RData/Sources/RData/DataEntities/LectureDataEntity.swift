import Foundation

public struct LectureDataEntity: Identifiable, Codable {

    public let id: String
    public let title: String
    public let category: CategoryDataEntity?
    public let mediaURL: URL
    public let imageURL: URL?
    public let queued: Bool
}

// MARK: - Storage Extensions to get the entities from data
// This is placed here because storage should not know about data.
// In the future Storage can be extracted to its own module.

extension StorageData {

    func lecturesDataEntities() -> [LectureDataEntity] {

        let entities = lectures.map { lectureStorage in

            let category = categories.first(where: { $0.id == lectureStorage.categoryId})

            let newLecture = LectureDataEntity(id: lectureStorage.id,
                                               title: lectureStorage.title,
                                               category: category?.dataEntity,
                                               mediaURL: lectureStorage.mediaURL,
                                               imageURL: lectureStorage.imageURL,
                                               queued: lectureStorage.queued)
            return newLecture
        }

        return entities
    }
}

// Temporary solution to have a mutable data store
extension MutableStorageData {

    func lecturesDataEntities() -> [LectureDataEntity] {

        let entities = lectures.map { lectureStorage in

            let category = categories.first(where: { $0.id == lectureStorage.categoryId})

            let newLecture = LectureDataEntity(id: lectureStorage.id,
                                               title: lectureStorage.title,
                                               category: category?.dataEntity,
                                               mediaURL: lectureStorage.mediaURL,
                                               imageURL: lectureStorage.imageURL,
                                               queued: lectureStorage.queued)
            return newLecture
        }

        return entities
    }
}
