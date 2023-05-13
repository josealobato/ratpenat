import Foundation
import JToolKit
import struct Entities.Lecture

enum InteractorEvents {

    enum Input {

        case loadInitialData
        case select(String)
        case play(String)
        case enqueue(String)
        case delete(String)
    }

    enum Output: Equatable {

        case startLoading
        case refresh([Lecture])

        static func == (lhs: InteractorEvents.Output, rhs: InteractorEvents.Output) -> Bool {

            switch (lhs, rhs) {
            case (.startLoading, .startLoading): return true
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
