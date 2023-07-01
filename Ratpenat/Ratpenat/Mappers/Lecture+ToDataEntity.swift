import Foundation
import struct Entities.Lecture
import struct RData.LectureDataEntity

extension Lecture {

    func toDataLecture() -> LectureDataEntity? {

        guard let uuid = UUID(uuidString: id) else { return nil }
        
        let categoryData = category?.toDataCategory()

        return LectureDataEntity(id: uuid,
                                 title: title,
                                 category: categoryData,
                                 mediaURL: mediaURL,
                                 queuePosition: queuePosition,
                                 playPosition: playPosition,
                                 played: played,
                                 state: LectureDataEntity.State(rawValue: state) ?? .managed)
    }
}
