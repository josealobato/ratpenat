import Foundation
import JToolKit
import struct Entities.Lecture

enum InteractorEvents {

    enum Input {

        case loadInitialData
        case playToggle
    }

    enum Output: Equatable {

        struct LectureData: Equatable {

            let lecture: Lecture
            let audio: AudioInfo
        }

        case startLoading
        case noLecture
        case refresh(LectureData)

        static func == (lhs: InteractorEvents.Output, rhs: InteractorEvents.Output) -> Bool {

            switch (lhs, rhs) {
            case (.startLoading, .startLoading): return true
            case (.noLecture, .noLecture): return true
            case let (.refresh(lhsValue), .refresh(rhsValue)):
                return lhsValue == rhsValue
            default: return false
            }
        }
    }
}

protocol InteractorInput: AnyObject, AutoMockable {

    func request(_ event: InteractorEvents.Input) async
}

protocol InteractorOutput: AnyObject, AutoMockable {

    func dispatch(_ event: InteractorEvents.Output)
}
