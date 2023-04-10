import Foundation
import struct Entities.Lecture

struct LectureViewModel: Identifiable, Equatable {

    let id: String
    let title: String
    let isPlaying: Bool

    static var none: LectureViewModel {
        LectureViewModel(id: "",
                         title: "",
                         isPlaying: false)

    }
}

extension LectureViewModel {

    static func build(from data: InteractorEvents.Output.LectureData) -> LectureViewModel {

        LectureViewModel(id: data.lecture.id,
                         title: data.lecture.title,
                         isPlaying: data.audio.isPlaying)
    }
}
