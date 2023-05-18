import Foundation
import struct Entities.Lecture

struct LectureViewModel: Identifiable, Equatable {

    let id: String
    let title: String
    let subtitle: String
    let imageName: String
    let isStacked: Bool
}

extension LectureViewModel {

    static func build(from lecture: Lecture) -> LectureViewModel {

        LectureViewModel(id: lecture.id,
                         title: lecture.title,
                         subtitle: lecture.category?.title ?? "",
                         imageName: lecture.defaultImageName,
                         isStacked: lecture.isStacked)
    }
}
