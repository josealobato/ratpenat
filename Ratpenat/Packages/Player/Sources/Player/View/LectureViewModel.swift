import Foundation
import struct Entities.Lecture

struct LectureViewModel: Identifiable, Equatable {

    let id: String
    let title: String

    static var none: LectureViewModel {
        LectureViewModel(id: "00",
                         title: "No Lecture to play")

    }
}

extension LectureViewModel {

    static func build(from lecture: Lecture) -> LectureViewModel {

        LectureViewModel(id: lecture.id,
                         title: lecture.title)
    }
}
