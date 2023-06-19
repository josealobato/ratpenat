import Foundation
import RData
import struct Entities.Category
import struct Entities.Lecture

// MARK: - Mappers

extension LectureDataEntity {

    func entity() -> Lecture {

        Lecture(id: self.id.uuidString,
                title: self.title,
                category: self.category?.entity(),
                mediaURL: self.mediaURL,
                imageURL: self.imageURL,
                queuePosition: self.queuePosition,
                playPosition: self.playPosition,
                played: self.played)
    }
}

extension CategoryDataEntity {

    func entity() -> Entities.Category {

        Category(id: self.id.uuidString,
                 title: self.title,
                 imageURL: self.imageURL,
                 defaultImage: self.defaultImage)
    }
}

extension Lecture {

    func dataEntity() -> LectureDataEntity {

        LectureDataEntity(id: UUID(uuidString: self.id) ?? UUID(),
                          title: self.title,
                          category: self.category?.dataEntity(),
                          mediaURL: self.mediaURL,
                          queuePosition: self.queuePosition,
                          playPosition: self.playPosition,
                          played: self.played)
    }
}

extension Entities.Category {

    func dataEntity() -> CategoryDataEntity {

        CategoryDataEntity(id: UUID(uuidString: self.id) ?? UUID(),
                           title: self.title,
                           imageURL: self.imageURL,
                           defaultImage: self.defaultImage)
    }
}
