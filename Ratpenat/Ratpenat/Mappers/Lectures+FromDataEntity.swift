import Foundation
import struct Entities.Lecture
import struct RData.LectureDataEntity

extension LectureDataEntity {

    func toLecture() -> Lecture {

        Lecture(id: id,
                title: title,
                location: location)

    }
}
