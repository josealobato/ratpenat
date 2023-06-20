import Foundation

public struct LectureDataEntity: Identifiable, Equatable {
    
    public let id: UUID
    public var title: String
    public var category: CategoryDataEntity?
    public var mediaURL: URL
    public var imageURL: URL?
    public var queuePosition: Int?
    public var playPosition: Int?
    public var played: [Date]

    public enum State: String, Codable {
        case new
        case managed
        case archived
    }
    public var state: State

    public init(id: UUID,
                title: String,
                category: CategoryDataEntity? = nil,
                mediaURL: URL, imageURL: URL? = nil,
                queuePosition: Int? = nil,
                playPosition: Int? = nil,
                played: [Date] = [],
                state: State = State.new) {
        
        self.id = id
        self.title = title
        self.category = category
        self.mediaURL = mediaURL
        self.imageURL = imageURL
        self.queuePosition = queuePosition
        self.playPosition = playPosition
        self.played = played
        self.state = state
    }
}

// MARK: - Extensions to convert to
// This is placed here because storage should not know about data.
// In the future Storage can be extracted to its own module.

extension LectureDataEntity {

    func storedData() ->  LectureStorage {

        var imagePath: String? = nil
        if let imageURL = self.imageURL {
            imagePath = pathFromAbsoluteURL(url:imageURL)
        }

        return LectureStorage(id: self.id,
                              title: self.title,
                              categoryId: self.category?.id.uuidString,
                              mediaPath: pathFromAbsoluteURL(url:self.mediaURL),
                              imagePath: imagePath,
                              queuePosition: self.queuePosition,
                              playPosition: self.playPosition,
                              played: self.played,
                              state: LectureStorage.State(rawValue: self.state.rawValue) ?? .new)
    }
}


// MARK: - Storage Extensions to get the entities from data
// This is placed here because storage should not know about data.
// In the future Storage can be extracted to its own module.

// Temporary solution to have a mutable data store
extension StorageData {

    func lecturesDataEntities() -> [LectureDataEntity] {

        let entities = lectures.compactMap { lectureStorage -> LectureDataEntity?  in

            let category = categories.first(where: { $0.id.uuidString == lectureStorage.categoryId})

            guard let mediaURL = lectureStorage.mediaURL else { return nil }

            let newLecture = LectureDataEntity(id: lectureStorage.id,
                                               title: lectureStorage.title,
                                               category: category?.dataEntity,
                                               mediaURL: mediaURL,
                                               imageURL: lectureStorage.imageURL,
                                               queuePosition: lectureStorage.queuePosition,
                                               playPosition: lectureStorage.playPosition,
                                               played: lectureStorage.played,
                                               state: LectureDataEntity.State(rawValue: lectureStorage.state.rawValue) ?? .new)
            return newLecture
        }

        return entities
    }
}
