import Foundation
import struct Entities.Lecture
import struct RData.LectureDataEntity

extension LectureDataEntity {

    func toLecture() -> Lecture {

        Lecture(id: id.uuidString,
                title: title,
                category: category?.toCategory(),
                mediaURL: mediaURL,
                imageURL: imageURL,
                queuePosition: queuePosition)

    }
}
