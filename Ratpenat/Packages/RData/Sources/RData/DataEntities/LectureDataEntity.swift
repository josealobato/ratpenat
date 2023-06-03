import Foundation

public struct LectureDataEntity: Identifiable, Equatable {
    
    public let id: String
    public var title: String
    public var category: CategoryDataEntity?
    public var mediaURL: URL
    public var imageURL: URL?
    public var queuePosition: Int?
    public var playPosition: Int?
    public var played: [Date]

    public init(id: String,
                title: String,
                category: CategoryDataEntity? = nil,
                mediaURL: URL, imageURL: URL? = nil,
                queuePosition: Int? = nil,
                playPosition: Int? = nil,
                played: [Date] = []) {
        
        self.id = id
        self.title = title
        self.category = category
        self.mediaURL = mediaURL
        self.imageURL = imageURL
        self.queuePosition = queuePosition
        self.playPosition = playPosition
        self.played = played
    }
}

// MARK: - Extensions to convert to
// This is placed here because storage should not know about data.
// In the future Storage can be extracted to its own module.

extension LectureDataEntity {

    func storedData() ->  MutableLectureStorage {

        MutableLectureStorage(id: self.id,
                              title: self.title,
                              categoryId: self.category?.id,
                              mediaURL: self.mediaURL,
                              imageURL: self.imageURL,
                              queuePosition: self.queuePosition,
                              playPosition: self.playPosition)
    }
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
                                               queuePosition: lectureStorage.queuePosition,
                                               playPosition: lectureStorage.playPosition)
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
                                               queuePosition: lectureStorage.queuePosition,
                                               playPosition: lectureStorage.playPosition)
            return newLecture
        }

        return entities
    }
}
