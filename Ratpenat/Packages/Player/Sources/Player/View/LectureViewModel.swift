import Foundation
import struct Entities.Lecture

struct LectureViewModel: Identifiable, Equatable {

    let id: String
    let title: String
    let isPlaying: Bool
    let totalLenghtInSeconds: Int
    var currentPossitionInSeconds: Int

    static var none: LectureViewModel {
        LectureViewModel(id: "",
                         title: "",
                         isPlaying: false,
                         totalLenghtInSeconds: 0,
                         currentPossitionInSeconds: 0)

    }
}

extension LectureViewModel {

    static func build(from data: InteractorEvents.Output.LectureData) -> LectureViewModel {

        let currentPosition = Int(data.audio.currentPositionInOnePercent * Double(data.audio.durationInSecons))

        return LectureViewModel(id: data.lecture.id,
                         title: data.lecture.title,
                         isPlaying: data.audio.isPlaying,
                                totalLenghtInSeconds: data.audio.durationInSecons,
                         currentPossitionInSeconds: currentPosition)
    }
}
