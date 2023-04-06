import Foundation
import struct Entities.Lecture

struct LectureViewModel: Identifiable, Equatable {

    let id: String
    let title: String
}

extension LectureViewModel {

    static func build(from lecture: Lecture) -> LectureViewModel {

        LectureViewModel(id: lecture.id,
                         title: lecture.title)
    }
}
