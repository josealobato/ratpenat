import Foundation
import RData
import struct Entities.Category
import struct Entities.Lecture

// MARK: - Mappers

extension LectureDataEntity {

    func entity() -> Lecture {

        Lecture(id: self.id,
                title: self.title,
                category: self.category?.entity(),
                mediaURL: self.mediaURL,
                imageURL: self.imageURL,
                queuePosition: self.queuePosition,
                playPosition: self.playPosition)
    }
}

extension CategoryDataEntity {

    func entity() -> Entities.Category {

        Category(id: self.id,
                 title: self.title,
                 imageURL: self.imageURL,
                 defaultImage: self.defaultImage)
    }
}

extension Lecture {

    func dataEntity() -> LectureDataEntity {

        LectureDataEntity(id: self.id,
                          title: self.title,
                          category: self.category?.dataEntity(),
                          mediaURL: self.mediaURL,
                          queuePosition: self.queuePosition,
                          playPosition: self.playPosition)
    }
}

extension Entities.Category {

    func dataEntity() -> CategoryDataEntity {

        CategoryDataEntity(id: self.id,
                           title: self.title,
                           imageURL: self.imageURL,
                           defaultImage: self.defaultImage)
    }
}
