import Foundation
import struct Entities.Lecture
import struct RData.LectureDataEntity

extension LectureDataEntity {

    func toLecture() -> Lecture {

        Lecture(id: id,
                title: title,
                category: category?.toCategory(),
                mediaURL: mediaURL,
                imageURL: imageURL,
                isStacked: queued)

    }
}
